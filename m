Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794106229;
	b=QzQfkTMWETnI9YeF+Dit/2TFTb4JDdwFYeA7pbJgpU94BrqixHpK7xK4Jc3SgG855RKh
	 OLuAqrghE+/BXTpjfgh0eSa5se2J/C7VIphwbzBInDta+WdHLhHZ/VBHG18SmcILrNtfZ
	 WlnPdqTgslSP9JA2aJVPliHg5XdNR1xvinnircvaWzzWV1OIAQ8dVU3FXjGZ3WPmH5Gvf
	 4modF80UMCD4xak/3lUv8S4Ir5vTKa+y4Qu2gbRShzaD/rF+tPhKDX92CD/NwAdayx6Z4
	 JVhvvQOiqrg7J1JWxrYn9vhdKv3kIDuY/3sphn1BO/lrhUyEA5K5GoNq7zAyUulho6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794106229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+XgAKvL9Yz88WJI2U+RHkRWBYREJXUrZL2P4iN0ZY3c=;
	b=fVAAwkYRu3uzNxMZLM/FLt3OJ1Wx1CtONQwIu4bL4esFmVKgpCqKTePwyY1lXSBa5/8M
	 yjgysnVg8fILNUFcsZZXoZJMXxdwgZ3zlip151GS9DWS3EHzIXQxOm88mjvw99EXb+Roo
	 eHnuYVMc/23iqkiHm+Qqa6F50xffWLlb0FKJJDy4LZxrocmHbLdi5NO0M6bbrK11AYa5p
	 tD5m1A50CWoxLc569UUzMNKbAilXcz7YtdhGKods6Tjr22hu8qlbPG1Eu63wXoRSiis/K
	 TcpziT4KLraCqX9/vCwW8Me1Cglv/qVjqoyyqqwtuvtf4QIpO14tfuf0n9Fs7x8yJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rV9OCWC5;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CA606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Nov 2026 02:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C3CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rV9OCWC5
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so1466145e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 18:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794106227; x=1794711027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+XgAKvL9Yz88WJI2U+RHkRWBYREJXUrZL2P4iN0ZY3c=;
        b=rV9OCWC54JHnc2+elgYOl3F1cX5u5r2YX4E36xLsQbCNz+QaH6o10fMNpaqruDMCjU
         7w1i3BzMQXB8vvFjokaJEQ+5iD0QCIYQGOm+wQWv04cnUESwY9YB1o6wqFrTQqetE4Gn
         7JEzOWyLwbZ852yIybo/pV7ZqesvThY8h2zZUxyqg2yDLpT6TYzBhleGvnzCA4btnOYk
         PTCGmzKgjmyhhcK/qJPYdhjx7gbUJjiNo92kXyH8esiEcEoTZ+Nob2yGg6yC0c58/Eeu
         KdX2qoR5gl/FnwNco4JDmIheY3c/oC1rF4lbZmbKmJ76yV/x7wbLlDq4XJOrTY1Ml278
         fZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794106227; x=1794711027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+XgAKvL9Yz88WJI2U+RHkRWBYREJXUrZL2P4iN0ZY3c=;
        b=Ou/JefbNwNxzBwH4tFsKGj5QLWtPCAnTJRzREyc2eESFouYTEfGLon9/UPkiCubUCY
         EGm4YyPo4StzEdOeBUUuFkDnb4ynOxb1rCCedVtLEVWgVGL0x1PDJ9AOqRPMdyY/jeWE
         /9Wl6aWy2GcW3fGE2gbPJBfBXFVoiVJnzALPBpPfQ+F6In25F5CN2xwro+9Ql03vEPah
         kGIu07KZnVSFUOnsfXj9MjPAH/YwHBdL90/HarFVoyL8LAgW9/hg7p687QexbGbdmVh7
         wE5Dr0BEI+1fSQ7rTIQuNLd9V01sZUdyPIgy7eR+Zbw2A0hoSO1Jv3Qpo1aflI5hoTFO
         f0OA==
X-Forwarded-Encrypted: i=1; AKwUvBy0ykozW85j4YGyKCfYu5YnGurBZGmR3PLkxJb+Bt2HaYU3pLEeBrc/kL97BsbXDCfYJkSbEwi5r17gsLPADoK4nZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ul84heYrBION9p01jGksE+7CXjMJAZV0fRR+deUvDxf7Xdt1u
	d+ZCeCZ79hTp30o3D/q4kQ0cO5cVpoDlN6McsYdKP50zFHEzGjOVLDlu
X-Gm-Gg: AYBFou3SglvfVutGqHr2vxbmQpJscV1O1K/NMbJTRvKaZczE9hj2RItm4p72o4Cj0e2
	Bx2CTXhmMvZ1DT3PDpZJ6ckSyCSQR+V43y6qFxKQFvB4jCb9/IbKb4qnQsET9c5VHCavH0FPf3Y
	wSPxeFyHwT9XEpQpbdvDcvxCiqrNC68BzHZai8/MSqKvEmSjRkkspE5zh+QCdQtPQasY/VyHS42
	hSsDjl2tezUzqMUzI1hLkCVbaiRF13r/eoPBp+R7lj3FSD7m+I3D6sQ8jvspHtS3BjA+yAbJDyf
	C+Tffb8JHn2bOY8QaUez/f5DF+TwvRyej3c6xbC64xCIMwkgmhO1NgDjQcYthBwX+A2TO9Qrqak
	kpmpKxjGroe5srweRw4JNKWj5k/lvYExeXQhgYowTRCfaec7VzY9YaooAZ+sc5fVrCkAXqEZ/0Z
	Hg/IjeYzTnhKCKX0AJYZGYSs3F/ffopDVVGR6oq6jKXztulLZ/fV9hEbTc/vOOJxnkaSxw1e7+R
	v7XQuO1XnU8pn/9kmmqdhEHesVDBip6/OmXZMQMmKpDugL4yc/R/ropBAwiqo160/jrIR7w+Z65
	1vrjh7yxeMm0N7q4Z4ZJCHyoqxl5qSdUa0JUXc0rMtDwqyblI0hk1wWwYfJxO8PNsHaWZIOj1hF
	quWYoyHy0Huq/OX+O21sNcJknfGUSB4obcyhAuUiCBr7yDXIwL04hnr7RFSONbk2fkA==
X-Received: by 2002:a05:600c:190e:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4b960d9c5f8mr7744875e9.5.1794106227158;
        Sat, 07 Nov 2026 18:50:27 -0800 (PST)
Received: from maria-VMware-Virtual-Platform ([187.55.90.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f10c681sm22969665e9.10.2026.11.07.18.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:50:25 -0800 (PST)
From: Maria Sheikh <mariasheikh812@gmail.com>
To: cel@kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	trond.myklebust@primarydata.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev,
	julianbraha@gmail.com,
	Maria Sheikh <mariasheikh812@gmail.com>
Subject: [PATCH] sunrpc: Remove unused rpc_socket_reset_connection tracepoint
Date: Sun,  8 Nov 2026 07:49:42 +0500
Message-ID: <20261108024943.8130-2-mariasheikh812@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracepoint definitions consume kernel memory even when they are not
used. The rpc_socket_reset_connection tracepoint has had no callers
since commit 4efdd92c9211 ("SUNRPC: Remove TCP client connection reset
hack") removed the code that used it, but its definition was left
behind.
Remove unused definition. This reduces the size of sunrpc.ko by 628
bytes.

Fixes: 4efdd92c9211 ("SUNRPC: Remove TCP client connection reset hack")
Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
---
 include/trace/events/sunrpc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ff855197880d..a0d02d735a7c 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -950,7 +950,6 @@ DECLARE_EVENT_CLASS(xs_socket_event_done,
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_state_change);
 DEFINE_RPC_SOCKET_EVENT_DONE(rpc_socket_connect);
 DEFINE_RPC_SOCKET_EVENT_DONE(rpc_socket_error);
-DEFINE_RPC_SOCKET_EVENT_DONE(rpc_socket_reset_connection);
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_close);
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_shutdown);
 
-- 
2.53.0

