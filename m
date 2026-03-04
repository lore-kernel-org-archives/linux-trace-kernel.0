Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DE35B633
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640041; cv=none; b=AcsPrd4YS9szsXTqRz+Y7XcBcGqsOh/gS1zB5bhIBu7xhask2ISp52MjGAdNTmP+m3NNNebh0Na9GFuQfWD3dI2OHtsAatW4QEQRlJhuSi+5dnp4CShqFPBjTeSDs10S+K4gQ0/vdckvVdUUuDe26iZhrxzn93Ye+HSmhuG2IGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640041; c=relaxed/simple;
	bh=7REG7e7eRo2LxU+1EFfdE+Tg/P+KtVUgE1UdHUpYeqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7ETOpgPDYOKQ2/C6CdSp0sipg0uXfFb7ZoYeLycY6GvOAU4t+776izDCAhd96tD/DaOoK6MKR/gFhDt+9/W/ZiyFDfoBrfrx0pyFuLu1feW0KOe+usrqgHA3RhdIjZcvZ3KIrhRT61WDg+MMgWaZ2MluyU9sVz50Hah6qD6x1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=a+mo6D77; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="a+mo6D77"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c5cce2c6so1095814f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640038; x=1773244838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p91XYxkA2zwDeIW6zeLvmoR6wJYLphT9dGZNIHh7FC0=;
        b=a+mo6D77gQakkEaolTxn15deziNA3EDNqfo5B2nIYDDcABV5Z2Nr0N30J/A8ht9L7l
         DYR9BzVcDr8OooS+HU5+vXfewsT8+92hnDqcYFvbRQeByGk76a/yd0R+3FRBPW356ZFX
         gUkgSvQ5m44kd9j+1LCFPS+S1WCg3jnGUeEB8kNtT40M+pCXzyNEr3Dz4jfwQeiL0uh9
         8JOvqLdGIMAA44vz4fB1qRO3SQcsWZk4QqsfziHlRhGOj2cTulsVvWFgq26K166QXK8A
         ZLRupfodJOZHzgt5WJQHemEvjGublGRwhIIL37455QhBmqnetUQT4hlq0JkIFwb3Ki1Z
         MwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640038; x=1773244838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p91XYxkA2zwDeIW6zeLvmoR6wJYLphT9dGZNIHh7FC0=;
        b=gQblJDtFRyZupYMM11KQzpD0m+WSSdpUGEbHxopHOJPA0yMOy/m8EL41rqsWU5XOv/
         PY0UwTqgLCyLdAEyVnqFPC0iZfq4e5y0cscy+fnL0nzJt2mxKSTreKlHYEZQBK/8SaVB
         eruhw49l8BUqHZPXmMNkFhvzEWh0g2z2FK7YrVExmB9PyDZafn0B2iNBxoQDHJmtmo5I
         EJ1mtMVJzBY7R1x5TkYgpT/xG3GbF77dHwuWV1VN41AIaM168Dywz56OllCtAylld+cL
         RXS/WCD1aMGmSqitvbKWRnngP+G5ozuj4ZpUFxBEM53FWK7jEqvM7MysiZg6U8fsVGwt
         Jexg==
X-Forwarded-Encrypted: i=1; AJvYcCXaTnmU8s5QuWlsW+2D+Gmp59Ts5eYuw+UzeI4StboRFlRz4HWA+Pis4lNH6Z/mJM1UufmpAqUZrzhk/RhubKtpTvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3KL7770qHeTrxzR6eVq39HJp1qGuVVItHFLO5/bRLlzFbsEx
	b+B4JXNFSdfYIOjAklk9GR4Egs48IVuJaROvoREs0z+rM1y46QsFXFA7x+YSQu3VbSI=
X-Gm-Gg: ATEYQzz1r2VOwG99CoEUOtPpqo9vYsSIe+efIgXYkIMevA+nwuA62iqktGZNfFjx/m/
	6Aj2i0MZNW3BKmxATVHNYpp9ChsVuXV+gKbXmeKHOMI1MRKwv3e873nCl3WL4FgM6lCxBecJ90S
	+4H2Zh5eJUWn1lMz4AThrzLR79aBiGm4DkwcmfjwBdd+2eP27E446Uv78UfE+xkWLeOX/KCJ5UH
	BxbecXWE4eFFTh5GgkzrXshu3g5GLbnEM57o/q4I6921Dt1dqPDopfqpDJNHIcn2dqBtXxOZf4R
	K3wBW2sGqBHYqzuewswJoEoaa252eOobJj8zgRdUbYB4uuhUi3eJV7qrk3TCgS8JqHf/qW3/P4b
	zOqt/lQiE1XJe4h04VyiDyEauf6UTUqbEVqYtGHmWm//yQeQQ/XwRTGgHDeKxHS0/HqxV2yYoE3
	01VvppdEr3FOLGRdaaFD0zLG4yJnpwZiidq+Cb+UKpCgEiWg==
X-Received: by 2002:a5d:5f91:0:b0:439:c43a:acb6 with SMTP id ffacd0b85a97d-439c7f64efdmr4412616f8f.10.1772640037350;
        Wed, 04 Mar 2026 08:00:37 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b272sm42727213f8f.24.2026.03.04.08.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:36 -0800 (PST)
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
Subject: [PATCH net-next v3 05/13] devlink: support index-based lookup via bus_name/dev_name handle
Date: Wed,  4 Mar 2026 17:00:14 +0100
Message-ID: <20260304160022.6114-6-jiri@resnulli.us>
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

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- unify return value -ENODEV even in case non-numeric dev_name
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition here from patch #7
---
 include/uapi/linux/devlink.h | 2 ++
 net/devlink/netlink.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index e73e39116365..5db931a0091c 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -208,6 +208,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-ENODEV);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
 		    strcmp(devlink_dev_name(devlink), devname) == 0)
-- 
2.51.1

