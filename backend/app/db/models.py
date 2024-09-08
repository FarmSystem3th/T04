from sqlalchemy import Column, ForeignKey, Integer, String, Text, DateTime, Time, Boolean
from sqlalchemy.orm import relationship, Mapped, mapped_column
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime
from pytz import timezone

Base = declarative_base()


class User(Base):
    __tablename__ = 'users'

    user_id = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    user_name = Column(String(50), nullable=False, unique=True)
    user_password = Column(String(255), nullable=False)
    user_gender = Column(String(1), nullable=True)
    user_birthdate = Column(DateTime, nullable=True)
    user_age = Column(Integer, nullable=True)
    user_k_age = Column(Integer, nullable=True)
    user_address = Column(String(255), nullable=True)
    user_type = Column(Boolean, nullable=True)
    user_biography = Column(String(255), nullable=True)
    user_nickname = Column(String(20), nullable=True)
    user_email = Column(String(255), nullable=True)
    user_employed = Column(Boolean, nullable=True)
    has_pet = Column(Boolean, nullable=True)
    has_disease = Column(Boolean, nullable=True)
    user_zipcode = Column(Integer, nullable=True)
    user_eupmyeondong = Column(String(20), nullable=True)
    user_sido = Column(String(100), nullable=True)
    user_sigungu = Column(String(100), nullable=True)
    user_phone = Column(String(20), nullable=True)
    user_realname = Column(String(20), nullable=True)

    bookmarks = relationship("Bookmark", foreign_keys="Bookmark.user_id", back_populates="user")
    bookmarks_received = relationship("Bookmark", foreign_keys="Bookmark.bookmarked_user_id", back_populates="bookmarked_user")
    chat_rooms_a = relationship("ChatRoom", foreign_keys="[ChatRoom.chat_user_a_id]", back_populates="user_a")
    chat_rooms_b = relationship("ChatRoom", foreign_keys="[ChatRoom.chat_user_b_id]", back_populates="user_b")
    chat_messages_sent = relationship("ChatMessage", foreign_keys="[ChatMessage.message_sender_id]",
                                      back_populates="sender")
    chat_messages_received = relationship("ChatMessage", foreign_keys="[ChatMessage.message_receiver_id]",
                                          back_populates="receiver")
    houses = relationship("House", back_populates="user")
    liked = relationship("Liked", foreign_keys="[Liked.user_id]", back_populates="user")
    liked_by = relationship("Liked", foreign_keys="[Liked.target_id]", back_populates="target")
    living_time = relationship("LivingTime", uselist=False, back_populates="user")
    matchings_sent = relationship("Matching", foreign_keys="[Matching.matching_sender_id]", back_populates="sender")
    matchings_received = relationship("Matching", foreign_keys="[Matching.matching_receiver_id]",
                                      back_populates="receiver")
    notifications = relationship("Notification", back_populates="user")
    policy_agreements = relationship("PolicyAgreed", back_populates="user")
    reports_made = relationship("Report", foreign_keys="[Report.reporting_user_id]", back_populates="reporting_user")
    reports_received = relationship("Report", foreign_keys="[Report.reported_user_id]", back_populates="reported_user")
    social_accounts = relationship("SocialAccount", back_populates="user")
    user_adjectives = relationship("UserAdjective", back_populates="user")
    user_interests = relationship("UserInterest", back_populates="user")
    user_life_services = relationship("UserLifeService", back_populates="user")
    user_want_adjectives = relationship("UserWantAdjective", back_populates="user")
    sessions = relationship("UserSession", back_populates="user")

    def verify_password(self, password: str) -> bool:
        return self.user_password == password


class InterestCategory(Base):
    __tablename__ = 'interest_category'

    interest_category_id = Column(Integer, primary_key=True, nullable=False)
    interest_category_name = Column(String(20), nullable=False)

    user_interests = relationship("UserInterest", back_populates="interest_category")


class UserInterest(Base):
    __tablename__ = 'user_interest'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    interest_category_id = Column(Integer, ForeignKey('interest_category.interest_category_id'), primary_key=True,
                                  nullable=False)

    user = relationship("User", back_populates="user_interests")
    interest_category = relationship("InterestCategory", back_populates="user_interests")


class Adjective(Base):
    __tablename__ = 'adjectives'

    adj_id = Column(Integer, primary_key=True, nullable=False)
    adj_name = Column(String(50), nullable=False)

    user_adjectives = relationship("UserAdjective", back_populates="adjective")
    user_want_adjectives = relationship("UserWantAdjective", back_populates="adjective")


class UserAdjective(Base):
    __tablename__ = 'user_adjectives'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    adj_id = Column(Integer, ForeignKey('adjectives.adj_id'), primary_key=True, nullable=False)

    user = relationship("User", back_populates="user_adjectives")
    adjective = relationship("Adjective", back_populates="user_adjectives")


class UserWantAdjective(Base):
    __tablename__ = 'user_want_adjectives'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    wanted_adj_id = Column(Integer, ForeignKey('adjectives.adj_id'), primary_key=True, nullable=False)

    user = relationship("User", back_populates="user_want_adjectives")
    adjective = relationship("Adjective", back_populates="user_want_adjectives")

class UserLifeService(Base):
    __tablename__ = 'user_life_service'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    life_service = Column(Text, nullable=True)

    user = relationship("User", back_populates="user_life_services")


class LivingTime(Base):
    __tablename__ = 'living_time'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    bedtime = Column(Time, nullable=True)
    wakeup_time = Column(Time, nullable=True)

    user = relationship("User", back_populates="living_time")


class Bookmark(Base):
    __tablename__ = 'bookmark'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    bookmarked_user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)

    user = relationship("User", foreign_keys=[user_id], back_populates="bookmarks")
    bookmarked_user = relationship("User", foreign_keys=[bookmarked_user_id], back_populates="bookmarks_received")


class ChatRoom(Base):
    __tablename__ = 'chat_room'

    chat_id = Column(String(36), primary_key=True, nullable=False)
    chat_user_a_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    chat_user_b_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    chat_is_destroyed = Column(Boolean, nullable=False, default=False)

    user_a = relationship("User", foreign_keys=[chat_user_a_id], back_populates="chat_rooms_a")
    user_b = relationship("User", foreign_keys=[chat_user_b_id], back_populates="chat_rooms_b")
    chat_messages = relationship("ChatMessage", back_populates="chat_room")


class ChatMessage(Base):
    __tablename__ = 'chat_message'

    message_id = Column(Integer, primary_key=True, nullable=False)
    chat_id = Column(String(36), ForeignKey('chat_room.chat_id'), primary_key=True, nullable=False)
    message_sender_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    message_receiver_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    message_content = Column(Text, nullable=False)
    message_time = Column(DateTime, nullable=False)
    message_read = Column(Boolean, nullable=False)

    chat_room = relationship("ChatRoom", back_populates="chat_messages")
    sender = relationship("User", foreign_keys=[message_sender_id], back_populates="chat_messages_sent")
    receiver = relationship("User", foreign_keys=[message_receiver_id], back_populates="chat_messages_received")


class House(Base):
    __tablename__ = 'house'

    house_id = Column(String(36), primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    house_address = Column(String(255), nullable=False)
    house_duration = Column(Integer, nullable=False)
    house_type_id = Column(Integer, ForeignKey('house_type.house_type_id'), nullable=False)
    house_room = Column(Integer, nullable=False)
    house_bathroom = Column(Integer, nullable=False)
    house_elevator = Column(Boolean, nullable=True)
    house_area = Column(Integer, nullable=False)
    register_date = Column(DateTime, nullable=False)
    is_matched = Column(Boolean, nullable=False, default=False)
    house_zipcode = Column(Integer, nullable=True)
    house_eupmyeondong = Column(String(20), nullable=True)
    house_sido = Column(String(100), nullable=True)
    house_sigungu = Column(String(100), nullable=True)

    user = relationship("User", back_populates="houses")
    house_type = relationship("HouseType", back_populates="houses")


class HouseType(Base):
    __tablename__ = 'house_type'

    house_type_id = Column(Integer, primary_key=True, nullable=False)
    house_type_name = Column(String(20), nullable=False)

    houses = relationship("House", back_populates="house_type")



class Liked(Base):
    __tablename__ = 'liked'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    target_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    is_liked = Column(Boolean, nullable=False)

    user = relationship("User", foreign_keys=[user_id], back_populates="liked")
    target = relationship("User", foreign_keys=[target_id], back_populates="liked_by")




class Matching(Base):
    __tablename__ = 'matching'

    matching_id = Column(String(36), primary_key=True, nullable=False)
    matching_sender_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    matching_receiver_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    matching_status = Column(Boolean, nullable=False, default=False)

    sender = relationship("User", foreign_keys=[matching_sender_id], back_populates="matchings_sent")
    receiver = relationship("User", foreign_keys=[matching_receiver_id], back_populates="matchings_received")


class Notification(Base):
    __tablename__ = 'notifications'

    noti_id = Column(String(36), primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    noti_type = Column(String(20), nullable=False)
    noti_context = Column(Text, nullable=False)
    noti_created_at = Column(DateTime, nullable=False)
    noti_read = Column(Boolean, nullable=False, default=False)

    user = relationship("User", back_populates="notifications")


class Policy(Base):
    __tablename__ = 'policy'

    policy_code = Column(String(2), primary_key=True, nullable=False)
    policy_name = Column(String(20), nullable=False)
    policy_terms = Column(Text, nullable=False)
    policy_required = Column(Boolean, nullable=False)

    policy_agreed = relationship("PolicyAgreed", back_populates="policy")


class PolicyAgreed(Base):
    __tablename__ = 'policy_agreed'

    user_id = Column(Integer, ForeignKey('users.user_id'), primary_key=True, nullable=False)
    policy_code = Column(String(2), ForeignKey('policy.policy_code'), primary_key=True, nullable=False)
    agreed_at = Column(DateTime, nullable=False)

    user = relationship("User", back_populates="policy_agreements")
    policy = relationship("Policy", back_populates="policy_agreed")


class Report(Base):
    __tablename__ = 'report'

    report_id = Column(String(36), primary_key=True, nullable=False)
    report_category_id = Column(Integer, ForeignKey('report_category.report_category_id'), nullable=False)
    reported_user_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    reporting_user_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    report_reason = Column(Text, nullable=False)
    report_time = Column(DateTime, nullable=False)

    reporting_user = relationship("User", foreign_keys=[reporting_user_id], back_populates="reports_made")
    reported_user = relationship("User", foreign_keys=[reported_user_id], back_populates="reports_received")
    report_category = relationship("ReportCategory", foreign_keys=[report_category_id], back_populates="reports_category")


class ReportCategory(Base):
    __tablename__ = 'report_category'

    report_category_id = Column(Integer, primary_key=True, nullable=False)
    report_category_name = Column(String(20), nullable=False)

    reports_category = relationship("Report", back_populates="report_category")



class SocialAccount(Base):
    __tablename__ = 'social_account'

    social_id = Column(String(36), primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey('users.user_id'), nullable=False)
    social_type = Column(String(20), nullable=False)

    user = relationship("User", back_populates="social_accounts")




## user session

class UserLogin(Base):
    __tablename__ = 'user_login'

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    username: Mapped[str] = mapped_column(String(50), nullable=False)
    password: Mapped[str] = mapped_column(String(255), nullable=False)



class UserSession(Base):
    __tablename__ = 'user_sessions'

    session_id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey('users.user_id'))
    token = Column(String(2048), nullable=False)  # JWT token 저장
    created_at = Column(DateTime, default=datetime.now(timezone('Asia/Seoul')))

    def __repr__(self):
        return f"<JWT(token={self.token}, expires_at={self.expires_at})>"

    # Optional: Add relationship to User model if needed
    user = relationship("User", back_populates="sessions")
