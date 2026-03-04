Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30634DCE4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640033; cv=none; b=SXlZGMR6x34QdNqdEVp/BdAfFTPPdppIGJZSxL8FnCbXT7X9jMEWTFHcs6hnnMFEyXvyKuZ4/p07EenMduSzxcuhs1W8Y9XdQTX9IeYFUwnZu/U+jxMOzYYoHg6fJ4bjHWi1ThVLCNs1yuWUeK5pGwa8Jo57nTtfRtJkGjQFv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640033; c=relaxed/simple;
	bh=Vtm80qE6FuR56bwzyqwTxutZyqLSGPZTe2b3PkwM178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cj9PZTb5sQQQPU/FCAnKu19Bw/+QrKdLZiXVZ3MJ1TYpGHh5L674Kl5jRVUgg03sd/u5jry1L4DBUi3egGtud4EmPsXJbqJIrC/PHfODJfUun+RK0xNvEoQHzKlOXWba0FQnpxu/O6wlUi6NeA31bEZuVMRF6Bc7EiJv03pzuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HKgeK19B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HKgeK19B"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so80026835e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640030; x=1773244830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=HKgeK19BNnN/xfBdG3TeGtmGL4/I6csuNySXiK2cvgGVrlXff2jFACmEtRqt1l/BkT
         QS8uWnklsDMoiQGl9zO7SZwouW09GKKmMpK346Hlh5FEVTSNPBKXJ6jfQX15eXo1TdRF
         qlVD3h9UmKOPLDS//iY+ytByE8MGw49FZJ0V0I0NzZ1BCn2jCs591b0RE/Xpp3PoKF8s
         azTOhDeI7RpNIvy6vt/0kOKU8R7hgiFVSrd+0v6JuY2LYxG0CGCXMVcyGIdRmjW52VlM
         4zNYfYKPVl2jeoGMmQvDQRvR4toe5Z0JohC8zilCe0XoTEYzmcCm5+YF44VzPCPnLl7f
         dLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640030; x=1773244830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=q5CWNQX9gwVVZau0RcQz0BJbJStjT5th3r887vx9MSKF6a66lE2y7xEXsLmrknM7M6
         zWn+u7UqoghqsvWh7TszEo5sD7sRKdzKIS/5pIAH3qlZukBqK4vv/SbJiRzXaLUyCvhK
         5tS6DbWtOsonvYr+8Tq1BUZT3j1nPdzP/WOEfJovd28titoZoHT/rVnJB/b2APlwORz6
         8n0d9e5qObLnX988WZGaHC0sYZQ1lhY1fBlFd1qRb8QB+IsXVweW88NUsx7KIOB/Te06
         bWinaC8kEVX7IZS/Am5jnmJChTOfdDmcUjHKCs/JzHXPWOVIWg/KUFXwqkNzv2uEA+kF
         k/EA==
X-Forwarded-Encrypted: i=1; AJvYcCWv0Nn/xqj7Hp6/PBOXhJG5kKUPBntXqQrSQhq2m8UX4cndW+qSvjL1YJzoj6p4YmoEmH5R8ec46kmfNBV35dRtxpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhjaqkky/BOU49VVkUlaxg7ShyMRv5TeU9BdNv+oZAmzOfDcei
	SXUxUJR7tvsl0TEHv3srT9ll5zTWkuZ2vJ5Hm29zXHqebxNs1pBuIPXm7yEw0S0NEbs=
X-Gm-Gg: ATEYQzyy3K+zM4CuJIEgiG7V9NlkiQ+FgBesahyUyMH83RJx5YxJMV66Z0Gjvb+mYxk
	jF8Uei+hzcf7kiu88OAmA6F0gMZtnEqEERRq/28+eu2+NOjPTctkGrmD2xA2/6SqYZnnY/112cH
	t6bJ48X36Uu1l+7pmXczWwQnuDMeppWYP7SRDayNVd6yvmJskpK7kXY4asF3fUIkghFUotuegOR
	zdvkPX0CVhtPxntMpwOTpOmLIBqZnfisU02D806JEJIJbEgoW7gM6T53w6tJ5IEDHjIQDKL+YEi
	nImpkYa1j40/h61Kl5t8H26BUlqLC1HQm5ybjxhORLZtrmPg+6Y1FiFDVM8rx3jqAZ4DYEG0Nbf
	uQA8kbfeTHaQH3t913jocwTBZKKlXj6CMRSdTxlNGI+ewjLBWuBJgkKcI5yDkmwiRvLDbviquyD
	YPc27XsXz8nLFv2XMoxTNRCSJiFLzXcEtcHdnTjYX1VvZrpg==
X-Received: by 2002:a05:600c:1c21:b0:483:71f7:2794 with SMTP id 5b1f17b1804b1-48519866866mr45713755e9.15.1772640030032;
        Wed, 04 Mar 2026 08:00:30 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187ced3bsm56749265e9.8.2026.03.04.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:29 -0800 (PST)
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
Subject: [PATCH net-next v3 03/13] devlink: avoid extra iterations when found devlink is not registered
Date: Wed,  4 Mar 2026 17:00:12 +0100
Message-ID: <20260304160022.6114-4-jiri@resnulli.us>
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

Since the one found is not registered, very unlikely another one with
the same bus_name/dev_name is going to be found. Stop right away and
prepare common "found" path for the follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 56817b85a3f9..7b205f677b7a 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
-		    strcmp(devlink_dev_name(devlink), devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink_dev_name(devlink), devname) == 0)
+			goto found;
 		devlink_put(devlink);
 	}
 
 	return ERR_PTR(-ENODEV);
+
+found:
+	devl_dev_lock(devlink, dev_lock);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_dev_unlock(devlink, dev_lock);
+	devlink_put(devlink);
+	return ERR_PTR(-ENODEV);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
-- 
2.51.1

