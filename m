Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818435DA6E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640048; cv=none; b=K98fMINg0x9Q27VkdruM+13JIk24Fm+wxxiE+ZQ9qriyAQvQwZbbITnwCuXCAf4/C4hGF68/miTL5dpFNpkgyLSuN20V0ZdlEVJrbJ5u0tbJ93Om/FIglkvJ/Nhe0Pz6tjxqlky/LGzQe4SZueQ08KkqLlivOVRPucMTR0XvEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640048; c=relaxed/simple;
	bh=fJzhD58yHbnlYGX5HQnBg/2nPap4L8qe/YePr91l0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZirawKjM5n+guj8XHXq9gtOy+Adv4L1XkdNoyggtZz3OreHKkeduh+vuQ0ozSN78U9zGGubA/WX9iZHvV4517zyPoiorPBoOCheb/+zj6TvbLGDmQi+fY8QPyF7a9tlz5ta7ABup5B82EPsfKG0UuHM2JuDEinWuwGd2MCcCbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VYr1MgHL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VYr1MgHL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439afc58ac7so4045996f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640045; x=1773244845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjTLWhKo8JnJx7lW+15uLvz3vRStk+3vuWmhHzoD9L0=;
        b=VYr1MgHLXxBk495ZOSZox6rKhRufJalFxAWBo44CdkCH0pQpBs0RmOST9oMY5hK5+G
         Mbr1yEpTP+6R9Jt1z9uQ3MuBg9WbOHmG6m51jx3CFMUnWsB6gPj6rqgCN8wpAdAeSJdv
         U+3obFIw33/doWVKBz2XrF5wX+JQddGt48/Fs8ee9cymRU/irTaQuWVjDKAgSyixyboC
         OKLUk54/jtPaojlpmjbwwUspoJaB2LzcXvRg1sGTYsgJ0MUSRVYtqtO+C+lg096/6PIB
         0vzVM28DUfLsn0iZi36nJ3hMokugZdlxeed8pNY2udkS2NW6f/Gm8zeL2NduE4Sqk0YW
         9Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640045; x=1773244845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjTLWhKo8JnJx7lW+15uLvz3vRStk+3vuWmhHzoD9L0=;
        b=rEu1X1RGZQ4AFbo+K3FxiMb5fDcvshPv0YtJ8hIeIsxHFeUvtnnHGTBYJS1pR3tZ4x
         gfDp3BMih9pXbu9jk1nq+zaw0+gTH8OOBzmLE9OMbWEp4yAnmbQz2Jf8Ab6jvxRfww52
         fs7t/GddTne6oxfT/TA+fpKjIvzqzfeVK/2HSHu5kpD+k18Wui2kMvS4wUXClg5RB/hB
         5lu8yUcClEMl7PSG1no2V15c3R/Mdu7ASiY2Qu6i4rJ5FT8ZXEuYnRBTuDwna7hHl1Q2
         K2dgG4CxXV2vjtIDIXk6FSMGampEiKyvzU+vDEa17V3/BB/wuXbHeW4rRl/EdJlwEHxZ
         mSCg==
X-Forwarded-Encrypted: i=1; AJvYcCXvC1ssBN4qGNoe8Ls4fz8FWgnvgu57zVz5f8N5mVKTJ30GU0I4YqyK7k3lQq1wbdgWrXU3f/huPwGkee0+vs+zocA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkx8FAsI5sdv09w936qSaTWYjWsKcpXrelWqAaieb3HY+HKIr
	qFgeTzKziIhckyE2E2QbbggWcloADWUGAMxny4KK/KBwC0SximIS1lWRwnznimi1h5Y=
X-Gm-Gg: ATEYQzwbNmY6mZdGon69NWH9L4LwWrtZT3M+3bwoVwwBKoK8pHmz4umshUOBKmzOC1A
	zTISDz/cLHK5f1dD6Z47QeEiDULDKoIbdWTftb9c53AM9LH8CWGaiIkHiG0Ccj9agGCC7PsXumg
	EhQUPUSlweN008G7qaZA+b6kQpkNklWwckjlnqAw/M+bznaFTAvqBbEProLtdYlBT3p5EhLYsmN
	uXOr2NPqbt5E1OBbyGy6Rswj+pIOYcXo6IWNO370nDnPC3PtIZ4Oxj+wZDTjPCMH6JP0IoDmer9
	6FJ5MsEKnmONm0mcpwMiDr5C3OvS2NZ7y/euqAsdMtimvYe7B/50QU2UTEbNk2QaJ+kUjLbBpSO
	0Nzwp6VlmJKXPrNWn+CPSlgO6lqHYjK/dTCwn8O2V5NcRxK5s/jms6jpJKXg28y4Sw4s7HhZdmz
	zyh2zBNaFHmudYOLvcu/Uur6PtVP7/T+beXcIw8OD2MM3OCg==
X-Received: by 2002:a05:6000:26c2:b0:439:b541:a092 with SMTP id ffacd0b85a97d-439c7f99765mr5336210f8f.8.1772640039114;
        Wed, 04 Mar 2026 08:00:39 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm33042796f8f.5.2026.03.04.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:38 -0800 (PST)
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
Subject: [PATCH net-next v3 06/13] devlink: support index-based notification filtering
Date: Wed,  4 Mar 2026 17:00:15 +0100
Message-ID: <20260304160022.6114-7-jiri@resnulli.us>
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

Extend the notification filter descriptor with devlink_index so
that userspace can filter notifications by devlink instance index
in addition to bus_name/dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  4 ++++
 net/devlink/netlink.c       | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 395832ed4477..f0ebfb936770 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -205,6 +205,8 @@ struct devlink_obj_desc {
 	const char *dev_name;
 	unsigned int port_index;
 	bool port_index_valid;
+	unsigned int devlink_index;
+	bool devlink_index_valid;
 	long data[];
 };
 
@@ -214,6 +216,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 	memset(desc, 0, sizeof(*desc));
 	desc->bus_name = devlink_bus_name(devlink);
 	desc->dev_name = devlink_dev_name(devlink);
+	desc->devlink_index = devlink->index;
+	desc->devlink_index_valid = true;
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5db931a0091c..1b00aa1dbcf5 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -73,13 +73,19 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 		flt->dev_name = pos;
 	}
 
+	if (attrs[DEVLINK_ATTR_INDEX]) {
+		flt->devlink_index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
+		flt->devlink_index_valid = true;
+	}
+
 	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
 		flt->port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
 		flt->port_index_valid = true;
 	}
 
 	/* Don't attach empty filter. */
-	if (!flt->bus_name && !flt->dev_name && !flt->port_index_valid) {
+	if (!flt->bus_name && !flt->dev_name &&
+	    !flt->devlink_index_valid && !flt->port_index_valid) {
 		kfree(flt);
 		flt = NULL;
 	}
@@ -100,6 +106,9 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
 				   const struct devlink_obj_desc *flt)
 {
+	if (desc->devlink_index_valid && flt->devlink_index_valid &&
+	    desc->devlink_index != flt->devlink_index)
+		return false;
 	if (desc->bus_name && flt->bus_name &&
 	    strcmp(desc->bus_name, flt->bus_name))
 		return false;
-- 
2.51.1

