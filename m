Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515433BF690
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309863; cv=none; b=b56z438BSudpO5wEG5wGTuddmK8+14LvCyFI1pljE/Vfmu7qHDfOaPgdsTXTAM2Yii/6x6tis00Jcudfjw+YEw+3NFkLr11+UvPveE4zbqDIEBotkN+owGP1MxOhmUKjaTX0fnbAJCAsaqcysC/8pmIwjXgAkDv5ubn+r9cYyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309863; c=relaxed/simple;
	bh=xLsXwuVt8lGwGVFFyvY2JOLZOXAAfQeVNQWGZqC43oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbS/xHF7Vs2T8I3NxpnnVK/cp/2A2zNdbfMeNeyxTj2nCC1pii/lqaNVTuIrr/X9KDS4NkcgzU6WQ6JbDtJPkKwBqj1WGKxHSA3Sn2Oa0fCYUso5BY5Ye1LN44oxGCYf0yqkZ6lAfn6Qn5HJYWMQE1LBEwI0khmIqIlYdKY1du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JUee8Qun; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JUee8Qun"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso516186f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309859; x=1773914659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=JUee8QunVCarJIB7ly32JZiXD6VM53iMNKywSves0VBafjXSVLuOEwENnHsgch2+WN
         KSPyhF3oEu28k8eIFdtUZrgoWExq4+cD03JA/TecfX5dUSyve/bKqIHpJkq4RQhwJw5b
         ALK8ABS+14Db9gLNHv52/d8q/WAKMbenjHqr2+JNgU5TvcfV2s01rVbnuLcpcceZk6qq
         zSDSVyMFD3Mj9o5VWQuSC5CdqU8yYtTrwWiv1DWDXvRwsdkYcwb3662qUrZzkesE/7jK
         1M+7BF6h2x9ifyN9xIGuiweiYVuW9ztzUbl6/qDbfRXK687M1Caq9DvzItNbnUB9J3SG
         jfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309859; x=1773914659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=QkFDG9UzS0dV4DmsWlFNlNcNbZq8RySZ9j1Tq4QDfh1xbD/5+x4akDwVxqvhf4q5PD
         Cus5M1PF/0QI0n/ngsin/q7VQqgJN69urc4Fz/ejo/5yc617cFQp8T1wrRVA1vW5+q20
         6KgJaCCNomZ1x80woMihaOum9kKJ9J39E8fetTRcTopkE1Q8zUc7XXV3cadkH//ii7fR
         luxHfMBFCYlSWIl7SUznf8UHr45pmvnOeiGOu4JJ/OQ9NlKMk+aMEpk25eHodw/fIG5B
         lH7xcF8nLDKKtrxPlVRtigT6v9zr1tz41cFNGiTekWUpyxtlnkIUxnGE3HmzgullXD4v
         3o3w==
X-Forwarded-Encrypted: i=1; AJvYcCX2se3OjX1dYZERX5XJUFIDzElt4mVPlNdiA1h7mLM3nrVkqtlpJF29+KoyaiCkrfkRL5iwte1ta55Z4rL5uEq05oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6050rbTCCixlawhuNc96OsDEDeRach71GbDpUHOujh0JhDYNF
	i64bYubAfogP6JKw98lGH+2AH4nyELBHLYPVC0sL+Q37B7twUPZhp0xMch5LNSGJZ2s=
X-Gm-Gg: ATEYQzwm30gPoHBp/HN+DpWjvEbP/8UvpfHeToQLN409kOsc9DiEAYleT3TFi3Wfkvg
	kqd8B3d8U/D8YU9+jsPj8Fl+bHXABwZqFiujIUJWCDrYEQEJMRGWajsOhJ8/sO8zg5tWV8Nepp4
	4P18gJsZb+FW0VbJg108Ogpa+3CE8A3G4NAP/Z6pemP+rjAXsPLyHgJxqVGCyuX8KsnORQutjGS
	S2PSbBHgG+pIXLc3d9AHyqOFk0PZi2GUdh/5CeVF+FGKCspJxg3uaKJuTRFYeY1tpNqSME20DVe
	F2sPZXGhci58WQ7kjYZKm7/l4c1lNrcumqM5T79qxd8OVrNbkYT9FGTIjz7/hAALLcX4i20NmZ+
	ArTqDJARbyShsu9jyUjIF2VGmvKHNYq0wD9/Mp+9mxlRv4waKTMNRa2m/ny/T9q7ez/jxzd+MMG
	+x/I4Oii4tqiIddA==
X-Received: by 2002:a05:6000:230c:b0:439:b3a3:7239 with SMTP id ffacd0b85a97d-439f81bdb5amr10514615f8f.5.1773309858528;
        Thu, 12 Mar 2026 03:04:18 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe219c41sm6943586f8f.29.2026.03.12.03.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 08/13] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Thu, 12 Mar 2026 11:04:02 +0100
Message-ID: <20260312100407.551173-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that returns the driver name stored in devlink struct, and use it in
all trace events.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- using stored devlink->dev_driver
v1->v2:
- added missing symbol export
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0afb0958b910..45dec7067a8e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1613,6 +1613,7 @@ struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
 const char *devlink_bus_name(const struct devlink *devlink);
 const char *devlink_dev_name(const struct devlink *devlink);
+const char *devlink_dev_driver_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 32304ce9ad15..4f8edf77dfbe 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -23,7 +23,7 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(bool, incoming)
 		__field(unsigned long, type)
 		__dynamic_array(u8, buf, len)
@@ -57,7 +57,7 @@ TRACE_EVENT(devlink_hwerr,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(int, err)
 		__string(msg, msg)
 		),
@@ -87,7 +87,7 @@ TRACE_EVENT(devlink_health_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
 	),
@@ -118,7 +118,7 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
 		__field(u64, time_since_last_recover)
@@ -152,7 +152,7 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
 	),
@@ -183,7 +183,7 @@ TRACE_EVENT(devlink_trap_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
 		__array(char, input_dev_name, IFNAMSIZ)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index fcb73d3e56aa..34eb06d88544 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,12 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	return devlink->dev_driver->name;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1

