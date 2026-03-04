Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6A35CB6F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640046; cv=none; b=VBrpM3OOjvH+uMsf+J6oBqnusHmD88OYp5N6zGkUOlVLnGTHeQDXHiBCImE9aQ3VtjnETXrerLOPLldRNCPTR2P2oi8CcOoxb5J5D+iqYsggrhsgKp1Ht1PtTUh3aQcNu3s29i6OSlvFbve8l6d2cO+Y1nQSsVMXSCQeMpfgnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640046; c=relaxed/simple;
	bh=xLsXwuVt8lGwGVFFyvY2JOLZOXAAfQeVNQWGZqC43oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQVlk8D6lqBsrCD41IzA9TXmjkC6jVSRaUMA2zLNKeTvdSiZmmlRhNm6L4AyjyfYHeNhgFgPmRlCB1WjMEGITAzcrDvGuuGE4oYuz5C3nc/xDv8GEHeokDRETjtiiOpLh3dDpvvlyjvZy4+eVfT8khVXFTCtEgmRd+Zbk8MZcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=u4p0zvjt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u4p0zvjt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso2739022f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640043; x=1773244843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=u4p0zvjtV6a+Pt8dH+ZaS370YGWg9nTKM7pxNI53G/AEhMRIbPg2zVFqNgl9RxD1et
         phInIfD9SfsfCARb3SD/H4dr7rAfwLgYvwhIpmFe9q8iQ40KSfHhbct2xjLMYjTkql7b
         GRQ0kIckJmc6zIQJTdTWhKDP+uc33g4M+UMwzYDcv93b6EAiTB2ek122hvVll4Lx+LcK
         lVlZTExOJSse3Wo/aF8WsXh2/JeS3vnF3Z6lrUkqggDp4OKt+v+L/dT5STVm7uEx8NEj
         964z+CuNW/MQfS/FbDMEkR3kA73yg+48qx2U6QItWOV80nc+Dfz2GAOqq+jxztVU3IjP
         Bl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640043; x=1773244843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=sL4attOxoagIXVqr8ZRFXj+6XcaGlXPccYc5fQIoVeCMbGd9x7yT3DwO0wLryU/ze+
         R9ebILQH5Bs3nNRufx6VaHkOnFjdX2SAkgzejos7jUkITwwwntpsFQJ7s7Z7KTXkW4m4
         GsvcJd3BexncKIn9R92FHWMifz9TgP9grm2ouJLgezACmRviR+0sR3j5hnEnQ/wYyTxs
         NFOKXCU1FR3jBMSJAnWyz0aj/KUkdT4ghgnzJuutVY8QLxp4fv/YwQ89TV3WyJdBB2TC
         GwIw5Tg7cKKhSCPX4tZ5j3wxAG4sDPzUb8HJZVEoZE9EQTwMmcntAZsJqC58FIF+2ECG
         iGkA==
X-Forwarded-Encrypted: i=1; AJvYcCUfYVZGGhKM5BpTO+BGf/cj+gzSC8e0il4oSIH98z5sxPPAv6t2z3KI68voBE+xbnyMVamXm7An0VLIYSo/MTTqw7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJR9N5RcF0n6kaSEq8+JGL/ccsaF8/xLqNJ9HvFioTcE43PFaX
	jAhW6rZj4sb++CYznLrc3ptY2VSsAeCnCITUl0BXcy6qDnaie7iskNILnc38YcjIujI=
X-Gm-Gg: ATEYQzyWt23iC3OpLR1PM+CafGvB9yCw866/kuHe7saKPr/1l4DnTmTfM2s7ZYok/7B
	BY+Dbpv6htq9NAfFtD9I5mjtHe7MWS84F9h3vrHJw3MHdQILAGLG+5X/NzWmMY1MysF5UQ2ZHZQ
	hf2/1wQc7IEmkNWfy5nfO5WJNSJVCLD9W8ZhXufbBYS86S+HTdMaCJWuhgzC9bBrrJ/5qtFwhmO
	DCBj8iJ4U71Jw84/gETYQliuNFzNYe8v7hQ+YOnXlw7my9VxJcMMOrBniAtZy1QZQvdQfGlBU4I
	hBaXqwY/MYoinuSEXQEIh7MZ7b67H3vHiRdLaD68VJV3Dvbhd0p6uFwcDSoBM8F/sDV4Auhy0V+
	1f/5kmiy2XQKscnLHhl/mjKazX9NYH9hSKC/B+oVcnasXwl407d9VQZzf5tqQMgBOoH88fHo2L8
	0wX3giCDh/k+3ePWJWwxkcNQ6GQNi0rAFfBlXy51wnH54/wg==
X-Received: by 2002:a05:600c:138c:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-485197e7678mr46704165e9.0.1772640043013;
        Wed, 04 Mar 2026 08:00:43 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm20634679f8f.33.2026.03.04.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:42 -0800 (PST)
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
Subject: [PATCH net-next v3 08/13] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Wed,  4 Mar 2026 17:00:17 +0100
Message-ID: <20260304160022.6114-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
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

