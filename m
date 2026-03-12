Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E983BD624
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309854; cv=none; b=iZP0AcMEJ7cFNkmIvQsEfKVECvyF9jOOB/D0EPZs2yFEN2yG5o8tsmH8XFChrPw+gmC1yCtjm2SV+RjCjcabbEFr/dQqNRENxpJN3a7oPbhLKrUnSl+tn2LlBpnI706LDLJ0sfH/vGSilDPIKkQL6GVdJ8eUxKBceKKF9pA5Ptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309854; c=relaxed/simple;
	bh=BrwM4XM4KMM/lo8saPOgEzUdEI2YOnTiFYCS9aa1d5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYlRdj3YgwM5+J+KpDxMeGkVU5gJclRzcECsJ+CUKwm6Rq95U8D7VaV0lDzxmdS0H5hTruhcBe2D3d/788vvnIAfzPLBvPwhka7K2l11X5uZp8pkZPsEn2KqN3CJkrnx7UEzGzFb1PNZLa9vfQCXRo8g8BWY1vnS2rXFA8gS4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hfN87aCJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hfN87aCJ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1464336f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309851; x=1773914651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWrXUQ1J7/v/C4aUUHZrL7KMegfL3shCNXRwtxlNqOQ=;
        b=hfN87aCJOqIm4z4wcX8FfLHsxby1l08Nu8cXC18bO8m85Xr9YhiFndGuJzRd2h3Jfz
         8KdcgjPoQGnPF3o5OEl3hjJYJ0dY8sJP8WI2D0dnS3BRvK9u7Do28ZCSs/9cZwuF41cS
         gZPPe2eWCs043B6pDeKy7w2uh2R16KtezxkNzVM6DXxixWegY1M+EXepqxD1gpVXFLru
         WZQZb1b9NVJPENjWD7ob7V4c3Du6qulPHgcUl/NnihHJW0UxUBUCGo4uGpT+BO4iza6L
         04YjuQSNGrcecL2GVpYJMGiICg4NFY8tmmvI+4Yqg4wJ6LuotnIlmdwqjwNWNmn9f+5f
         IXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309851; x=1773914651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWrXUQ1J7/v/C4aUUHZrL7KMegfL3shCNXRwtxlNqOQ=;
        b=A5i+f0kefxoLydk6UwN7UxJqx08Gry+5AQtaP5DFtVRE7K1JDgRgnrT8K8NfC4pR+s
         SjOgUqZoToCxHTVxVuGFNEi/iqewBPt/HSVMVmXgVkvVQi3llWbmq4k9n3FjvhmgbB5Z
         tukaXm0S0rgIt8Mf8XXLJ/RrShAzI7UqpxcJ6LUCIObphGtgyeBRpb2IN0DAeqOeuYR8
         Zjsc3VhYURu9Br+tKfaQF/6N6kI5mZH6P2EuFUcwHlKCdtNx5qDPwz5+7tsEGy6hb2yO
         PeDhz3e45qqNiSHBDdpqlnNWB+E7Orh5qClp+RpopcxAy62KdgXYNBN7/ZhJ9tfs8lPJ
         uM8A==
X-Forwarded-Encrypted: i=1; AJvYcCWregrBZ3xHSWR11GJS3lXWNyBmw+Dqp9a3yeZEByyPW9cVgnzXJCAOb8UommMZvqmqyaCsc+SOLzH485qNZGvIO8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWD8sNx5gbYlAoTos7EkG2xYzYhxuOKdZErAFW4iR0eY+zI/Ev
	lU2ky6NLU17IkIBRN2mEzjSaq1fRaBXg0lYsk7KiA/5qwNtakb+PByC+Ced5zTkjSZk=
X-Gm-Gg: ATEYQzzZf9nWAYbEf47nEihUP6UAmZtTQPaNTZF9Uwm3ni2aQAYlDpupJ+P9dC06hUf
	OkTpFavbXbnK34J2f1/AWwxgNJ7gSYACfoIJQsLNrZEN0WLaCTOwbSq60NwgZzXHrjWcGRccPWX
	2N4uPkwwiCvgZxIsDOfBujKrg/AA+7dpqGWW02xSyolc84cybABplHOO5MKwIGXcSej2WYIIq8h
	lKgdHS2Fmt7SrE8WGKhryJatPEtWwYHozw1rcw8UINNxx11UR6SgveiKLBaDpZqs1XdrdRvGcdF
	sMp2cAZOD5vaFbVuHA9ttzyzKnaLwq94Tl1IOkFD50E3uS4LQhrmkHx46ktKHkBO2QTZ8JG242j
	RUZBo1pT2cf7Azr5j94rfzmjF/1gZ94b5+hozW2NkNqA3GOGBt0lzes/xGeXcDtCguxyM6bzuOF
	LB5m1xdFV1V2QC9g==
X-Received: by 2002:a05:600c:4443:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4854f56a097mr44614545e9.4.1773309850996;
        Thu, 12 Mar 2026 03:04:10 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f406sm212103385e9.13.2026.03.12.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:10 -0700 (PDT)
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
Subject: [PATCH net-next v4 02/13] devlink: add helpers to get bus_name/dev_name
Date: Thu, 12 Mar 2026 11:03:56 +0100
Message-ID: <20260312100407.551173-3-jiri@resnulli.us>
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

Introduce devlink_bus_name() and devlink_dev_name() helpers and
convert all direct accesses to devlink->dev->bus->name and
dev_name(devlink->dev) to use them.

This prepares for dev-less devlink instances where these helpers
will be extended to handle the missing device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- don't store bus_name/dev_name in devlink struct
---
 include/net/devlink.h          |  2 ++
 include/trace/events/devlink.h | 24 ++++++++++++------------
 net/devlink/core.c             | 12 ++++++++++++
 net/devlink/devl_internal.h    |  8 ++++----
 net/devlink/netlink.c          |  4 ++--
 net/devlink/port.c             |  4 ++--
 6 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..0afb0958b910 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1611,6 +1611,8 @@ struct devlink_ops {
 void *devlink_priv(struct devlink *devlink);
 struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
+const char *devlink_bus_name(const struct devlink *devlink);
+const char *devlink_dev_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index f241e204fe6b..32304ce9ad15 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -21,8 +21,8 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_ARGS(devlink, incoming, type, buf, len),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(bool, incoming)
 		__field(unsigned long, type)
@@ -55,8 +55,8 @@ TRACE_EVENT(devlink_hwerr,
 	TP_ARGS(devlink, err, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(int, err)
 		__string(msg, msg)
@@ -85,8 +85,8 @@ TRACE_EVENT(devlink_health_report,
 	TP_ARGS(devlink, reporter_name, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
@@ -116,8 +116,8 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_ARGS(devlink, reporter_name, health_state, time_since_last_recover),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
@@ -150,8 +150,8 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_ARGS(devlink, reporter_name, new_state),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
@@ -181,8 +181,8 @@ TRACE_EVENT(devlink_trap_report,
 	TP_ARGS(devlink, skb, metadata),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index d8e509a669bf..63709c132a7c 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -248,6 +248,18 @@ struct device *devlink_to_dev(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_to_dev);
 
+const char *devlink_bus_name(const struct devlink *devlink)
+{
+	return devlink->dev->bus->name;
+}
+EXPORT_SYMBOL_GPL(devlink_bus_name);
+
+const char *devlink_dev_name(const struct devlink *devlink)
+{
+	return dev_name(devlink->dev);
+}
+EXPORT_SYMBOL_GPL(devlink_dev_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 31fa98af418e..1b770de0313e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -174,9 +174,9 @@ devlink_dump_state(struct netlink_callback *cb)
 static inline int
 devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 {
-	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->dev->bus->name))
+	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink_bus_name(devlink)))
 		return -EMSGSIZE;
-	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
+	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, devlink_dev_name(devlink)))
 		return -EMSGSIZE;
 	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
 		return -EMSGSIZE;
@@ -211,8 +211,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 					    struct devlink *devlink)
 {
 	memset(desc, 0, sizeof(*desc));
-	desc->bus_name = devlink->dev->bus->name;
-	desc->dev_name = dev_name(devlink->dev);
+	desc->bus_name = devlink_bus_name(devlink);
+	desc->dev_name = devlink_dev_name(devlink);
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..56817b85a3f9 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,8 +193,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0) {
+		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
+		    strcmp(devlink_dev_name(devlink), devname) == 0) {
 			devl_dev_lock(devlink, dev_lock);
 			if (devl_is_registered(devlink))
 				return devlink;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1ff609571ea4..fa3e1597711b 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -220,8 +220,8 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 {
 	struct devlink *devlink = devlink_port->devlink;
 
-	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
-	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	return nla_total_size(strlen(devlink_bus_name(devlink)) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(devlink_dev_name(devlink)) + 1) /* DEVLINK_ATTR_DEV_NAME */
 	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
-- 
2.51.1

