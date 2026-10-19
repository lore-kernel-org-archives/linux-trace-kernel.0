Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FB4E0B6C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411437; cv=none; b=uMqWDYYcA5O8zZiTI7EdX3UiGxzWtD5pyM0IA7AAWNN6Bbt1wrxg0sVQpPxC5bwWhDhZrR6yXktGu6IU0sJLoKs4Db0ob3PUv21sen16ychs+I3UWaWRx04guiRP9MQMilMuOrVH+37mw39f5cct6Jb/FO+A034FK6+AZBXXxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411437; c=relaxed/simple;
	bh=MX+Iz+ShiaE8nHEd/iGh1hntzDuqO+M+7JVZ/MbnG2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tF0b/JHhMio3hCptucVcKmqHznLfnMYBZcW2Io7SAiLQ2JqBBnYipUax+MVO1YoxYgeISOYuq8eVMGRv9T4jbd2fRnQF8/tjRx6QGLFPYR73q4PHa2B6OKmNkMB+V1vZQR1xPnLb0EgJ4v4FqfVZwE28Wem3LG8dxYSG3nIr+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxvpULg5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxvpULg5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso21717025e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411434; x=1793016234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PWBhm50kJKv5rgN7AYPJlHAnuK3+SCL8hQ69bW0a2u8=;
        b=mxvpULg5Iral8pImNVhKjAhNRUReYYlYOXjQCXXnCM/0A9uWqOAhNajREey1AzDWZN
         tLmngT8F40hk2FmiamQtw/T7HARvfya95kTy+XIYbajIc6nO6bDwAcPhwb2txcNASxYA
         xbkXmL3DYxGN3gAMjHAh2LWdlmd3ZR24S0MjDclU2iTDpvLok274czKXm+7Y3fA8PkrA
         mwE8hSwhjlBiFqWP45kkBLvJXNX1SKZIbnHy5FPza46Hdiau4XKr93TdhSJeZCvXt9l2
         JJfKVg2bYZceGG366EUUDaftwSiXsUgkW95rWG3GF9Qy7d1Sh7B3RCukO+PYN5BfWsga
         ETug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411434; x=1793016234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWBhm50kJKv5rgN7AYPJlHAnuK3+SCL8hQ69bW0a2u8=;
        b=WT7d7tWQRNFMZoOV7GrTRwiQ8PXvFwTsC41OjXNqEX8U1jQuKedlWI6XPLH9+yBo5e
         v8RSr6oYW9RhMxqKLeQqRTSJYUigGC8KpR/39R/ffcfg+uyHDo5vnEXuZqN1TRd02if7
         WGH1Hk6+t+jDwFSxeQFTw2KqBCW9iQ95kfXuEIZ24Onjk9ynXacdTXETyFRsYuYM/HHS
         WafPK/SoU4ryaZXySH+4y9kNNgANBaMury1/+Ul0xoEQWnTEUHj5JZ6vn6L08IWU67Tg
         LmynuHZqNf7baQv9GSGyursZu4FjR78fs5agVW0Txr1PvhGLKmkFWCGUt1WJxIgVTlgi
         BSbA==
X-Forwarded-Encrypted: i=1; AKwUvBzvx2biAQCcFhqD8dJCIX5F1HEW7oVZ20N3zrAjd1r1wwlush7Z9DN+TK7/LBr5ZiF7aLN9nYtGTLGtWbOZQ1UxAQQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMZ9FXUxNItiXzJPK55+OqpHMRZr+88RMVBttNnRQNbc6+NHKQ
	smzu9LiiVZ6qQLc17IPH9DYbPmMrBNAlz4fB2/+TlEImwWYjFE42uUw5VVPnwNWVLmA=
X-Gm-Gg: AYBFou2aZXwQJ9ilnIWoRC45dLFtRRqe2jW/3U8tiqAlH6mMTXKp3osySLhiqCgn4N3
	ajotZvaFE0IBcexR9O/JIJTgu51JyW4EBZLusTRC5C53FINtyPEEO9Ch7voaY564BGUAmPLisI3
	H2gvJdT+3xDX2p7YEjx1ye53nThq/esF0StHEzbeM9d0zUarZvqLp+8A3+GC2uNUeYxwpU7SFte
	3/z7Y/dvWHLQmFjAgO5vH0s85PKFecbnOGol3bzAmdg8vNwpxyu005LVrc2WD399rclF8Lvwjue
	up1JbQyob9TvnWffTBHJ0ihP7edbl0zkiJSw+X6N0iKnklm5LsSHNY/ACRqs6rMNgWxRECKEHeJ
	32Ls0iIyYbnYe5HZ/25qbsBXZFlToWPO9sDAwi5VSlVEo+aCpsEwb+buzmisIJZNfyQU7UmIWYq
	MhZLeQjAH6t1Ehl9BJ593ema3+lkmGpNodgwR9x0dAV9Runfwd2nxWY2s3bmloECKk6oX3KyePc
	NcQ4YqdyprH0gehV8BFz8Q7JWx4SdUt/+WvZEJ9bZzWohEQloPSdlJ0MSXAVAMEVP8kFQ+rFHHO
	i/0fJdEJrZ7hzPEtB9tzv0e5IivRtxwYyIJ5LOE6p9r7Od2CktfHxMANkRcbLqsto7N2ZeC4JM4
	OHi5aZ6079HSdzwPjQlWUH8FvQUY=
X-Received: by 2002:a05:600c:820e:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a1d761637amr143638045e9.28.1792411433506;
        Mon, 19 Oct 2026 05:03:53 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-884a-68e2-6a4e-545c.rev.sfr.net. [2a02:8434:fda5:4201:884a:68e2:6a4e:545c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a35sm19555486f8f.7.2026.10.19.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:52 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Quote CPU masks containing comma-separated words
Date: Mon, 19 Oct 2026 14:03:32 +0200
Message-ID: <20261019120332.553567-1-edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftrace2bconf.sh writes the CPU mask without quotes. For a mask selecting
CPUs 0 and 32, the output is:

  ftrace.cpumask = 00000001,00000001

Bootconfig reads the two comma-separated words as separate array values.
When bconf2ftrace.sh applies the saved settings, it writes those values
on separate lines instead of restoring the original CPU mask.

Quote the mask so the commas remain part of a single value.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
This is my first kernel contribution, so I'd appreciate any feedback.

Tested with the exporter, bootconfig parser and generated replay commands
using tracefs fixtures for 00000001,00000001, 0f,ffffffff and 1.
The masks containing commas fail before the fix and pass afterwards;
the single-word mask passes in both cases.

 tools/bootconfig/scripts/ftrace2bconf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 8eed445c2..f8f288f90 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -238,7 +238,7 @@ instance_options() { # [instance-name]
 	fi
 	val=`cat $INSTANCE/tracing_cpumask`
 	if [ `echo $val | sed -e s/f//g`x != x ]; then
-		emit_kv $PREFIX.cpumask = $val
+		emit_kv $PREFIX.cpumask = "\"$val\""
 	fi
 	val=`cat $INSTANCE/tracing_on`
 	if [ "$val" = "0" ]; then

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

