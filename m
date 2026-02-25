Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8F3B9614
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026475; cv=none; b=LbIfALJ7wxZRMqwk+7dJPl9l9yHQHR0IQtytPqVZzdUtMZ0yo9c3aJzvEhkB62SAkzjJY7c6ZFnOXE+jN1lDSjWlqUznUXO/z7cCuQrsaJJLKGpbhqWxUqT0v4rrENZ22ybKkBQUKcGwfrJv5YPDnONobDXOBxgb6wtwyeH48t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026475; c=relaxed/simple;
	bh=r67EuCuSEgnlNDiIhyauM9QDSlOGLxMQaLPlJqQlJh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI+Fp61hOkZIyDHpE4xO9ScyWr6mKXV3ICTVVZodVQhHd/jWRHTxysw4nKoCNDyeXI0SiqsOllO7o6Ij5qZ0e+aZ9oFcqqBbrYrG+8P8fg512gWgc0y/Gg4Zle2TvkzheB3zrc0SqV6tzBsDb5p98arQtWL7VH/CNTzpHv0EbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AOZtH26y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AOZtH26y"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436e8758b91so4615805f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026472; x=1772631272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/FG3Lqra/1XuudAPK85QKV8ahCltY4VeAIS2Wk1ZgA=;
        b=AOZtH26yAWQzenMcaat2LyaeVktBl+Jnj+7qC0HivzbZlq83omf8hSwpOq6FT20g3I
         Wsx6R0ZcIlIDWIUO2smLNtr8eEpHBeYiL0svrDCZkcGogkpnr89jND7jqCxZQV7yHIEu
         7i1c3k5Sga1q3MXVDIJG2JykJ+pjz9OgDbpWmS5q6Zk3qOPKKhNiPANE7XTNSWfxbIwx
         LsUgV5BFPftdNHnnq/8jjMhQaSEtnras5bLxBagybHLb5SNih1BlQZl9fipS0xr6fw9L
         O6DTRPm5tbLxdGTiBIUvjyJkiFR4A0FjaV3iK8WBUMwSWU9P9lye+ufJu23vRjx7XEH+
         rcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026472; x=1772631272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/FG3Lqra/1XuudAPK85QKV8ahCltY4VeAIS2Wk1ZgA=;
        b=pgl1TgDOScok0nJ26UF4ZzrH6q8Ljt/mF87y/LxwWDsHBEVVN8CZrI1YrjDtPoXjr4
         sGHzFr9RvuBvlt9WN6t6ccW/bKTP1kJJx6xoBHvOLLk9vpP1NYoXfG2AdQlWx0INIJp6
         oUJx4V/oz7aL6SGEK8wV/hapODIHQ1/WSAkBPyy6uJMjNw+qqaAjTUNEshcUVOFbHJuR
         VC9gPqAGsTi3VjJG8c1JNnbu52wN/+lEeW+0OOjaG5uGNj2hqCd8/nb148HCUgEF/m7y
         Te6AYMcdGf644uoLAiWRQYqohJF/l3kQzkKHPX5OXPPdrUg7zVU2FtLcGtZlIBhZFbkJ
         jw6w==
X-Forwarded-Encrypted: i=1; AJvYcCVAHfcDOi7rSaXhP9mQxmnFFfGCbs7EgePFbaqSI3z7eYgOC0SFDDs3QjEDt5jait+4AES54iSpCURH3TDscls5cjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/SZbeYGSXBUpkDd5IIGW6+ZojS8od+2sOwBJ40nuJc4ng4o/g
	vyaZBlv/NdIPQwpmPQAovq0zug16OEBvsRI2zyAR+Wv60a8FM7UCsPMRMdRPqP8HTRU=
X-Gm-Gg: ATEYQzwtpJPeKcr795AkR7d5vZctUzNTp+tlHcMgvdk1QzHqOuXEoMqWekQ+sPIKTSW
	/z6ytvrspLYeNXBv5L/wSg0I33IgKNWqfnU1zAQEkTfVcdSfVG+UT+lre8eTGUIB3cwuY0BQ9Gj
	SrRus/mLl6nz3JqX3XuT/BqEQK3hOGVdDhTrvzatW/xQLbPbIChf8T0TtUWGyJkRww7pJYycIbC
	Ia1xnALvAMjrZwbush6O4Jgx1LIU95J9EhN2mRYzceeEfH8FitsDl/D+RxfxNJBlwjsupgTUBK6
	1rqJ0CEWtFw3R2CGK7G7q6J5291F51PALU4NcETjFowmGP4oDUFNGuF1DKHM4SWYDEO46bWXTI3
	6/gEO35lW1Ga1C415/Qr+PxX9V/veVdKSgBG8ef32vnej0zRHMlkX/WZtfmEJx9n9z5RmN4zdPS
	G6Vl72MNPOD8G8PkfgRuuEeLk+
X-Received: by 2002:a5d:5d05:0:b0:439:869a:a15 with SMTP id ffacd0b85a97d-439942fbac8mr908648f8f.42.1772026471792;
        Wed, 25 Feb 2026 05:34:31 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d401aasm33063361f8f.23.2026.02.25.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:31 -0800 (PST)
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
Subject: [PATCH net-next v2 06/10] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Wed, 25 Feb 2026 14:34:18 +0100
Message-ID: <20260225133422.290965-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that safely returns the driver name or NULL, and use it in all trace
events. The trace __string() macro handles NULL via __string_src(),
recording "(null)".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added missing symbol export
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  8 ++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

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
index 2dd6d45bec18..85ea5856d523 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,14 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	struct device *dev = devlink->dev;
+
+	return dev ? dev->driver->name : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1

