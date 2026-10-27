Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086645;
	b=Hd/Ym3XTPTklmHEYyBVBGNYLiDgRflv/Yu2H8ZrtLPmWbhv0hJZKDt8pcZa/RLiKQlV4
	 jOsKBHUd/iscco81DAWmYXhLZvQpFF5+xfXmgu8OvTO9zxXHPPWvOepAnfbf2nQ94MS0w
	 eGY/PXyJBstqjKfsQl81ZV+8jhquK8yXueY/SqVk/N1sJuSIPAHWgXk38vUnC1tv4mArA
	 E7ZPRS73eiPvuCCf3nQeLsEAy6uEKC7Jv6siAi/86jT70kbCoew/HNdSzv29TTT2JARL1
	 PPu1+LaBvIOQvgRJRFLGuA8aDRWoaNEtXxwTTqMbsgzN9wpXxzkXN8+h7mu6DWoPRJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vsy575Qvc3d/MeFu84YL8sRbt5XUdIJ7Cg8IpCyNi4I=;
	b=WsrgtTJ1cs2vIwG666q/RzPOGoD3bpHHRfyIJ04XMDtexA7IYt+exH18bZ9jnLf0CTyj
	 SjHg9LUpmxXo5YPKTKNwc774yA2a9R0a33e4mNKgOmNOSBaqGGkE/3v7NnM7csMetEHFu
	 GdNz7ZItkRvKQMFzT0NwCTI+E0PqkFHAFZmGfL+mw7HoqrRR8zxonXKGNHQvhWiAgac8m
	 zGPbMr89lz4Jl4jOKdaGXQBhwml5q7IH/rv6Qwd6PTPgwyEfaQyP++SzDNaqiXqImXOLM
	 l9BTLOshC1s87I0brv7pTOn+PKE5QRY3tT374TI3sMxmT+bnj3edMHBkby/5Zkxz0dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tHB2uq12;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9564606A324
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 07:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9564606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tHB2uq12
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b042c0728so1004796f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793086643; x=1793691443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vsy575Qvc3d/MeFu84YL8sRbt5XUdIJ7Cg8IpCyNi4I=;
        b=tHB2uq12SvGvkhaMBcCMOUo1ISJMmuSVxAqzVxC4t3mT0eDWlTi/hrdbv8EJdvcTXo
         GkGJaSvdgAOYLUnveWVIGWNhlG90+iOn5sJUPqDgkwrQxlwq9tvEJpcKzPGAuvPGZJGq
         NtWpg6FdiyZrKPAl9zadgoQ4APyC+BlPK0opOrUGQM86ZBzVJ0kWdc93rfkXysDiaLiV
         j7qNKsONJtIQ+Bag58VRAWqzMjcepnKjWHmLB0OScVtTHKmtMUpA2ZBbKnP676+4aXEt
         hoY/uaFWAfvo5Wj7eSiAiR+1nM+x0k90p8XMehMxdjY1dlj5D0pcO0aoaSc3efCVwzqo
         6RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086643; x=1793691443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsy575Qvc3d/MeFu84YL8sRbt5XUdIJ7Cg8IpCyNi4I=;
        b=Q7FeijqvlU+M8ulGdbOgbO92mlQHTQ2clf7gHC+jgOQtLLCsV1oLFSlmuoCtZwKg38
         HTsYzJqbCWs9XbikdXoNVsJRo2C6fJ2OHH9R4BGBxzV8AlFdg2ULIDQGJe8mDPcBaFxR
         O3J3dMq+6KadZydy2JjHfXsIPetV1Hm6AFyTACyH1bYSJIH2ZbMg/4pkMKbpUgd7rDtI
         k0uhtUrTDh7C63z7foJhhaD9EirrZh5ORMfPqIgkAgEz6lsD5znJtf9VWH1rIcKR7UqV
         Tln9pCkUr7+8JMzgNFw4o7uWix8IjEFMv5hBTAlwouw2gbIBUPgIOtHbAhHui3tYYx4K
         IWeA==
X-Forwarded-Encrypted: i=1; AKwUvByabASjWufxzPJHu9xySSBhP49gE99iijMTt8pbsE6DAkFD5xia+/u4cH3CYBYOBTz0PrzPG0FdnOM2b6yqOpwG1oY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBdQ9w40tZCCICgpWmXJFdRhUH04/Z66BF7tx1JF00suYN6Cpq
	OdZLzmBMTa9mJpC3C7+m2l6RJuxiusxC9OzWTT+rxAS7S+G+zlz4zTLcy6ItwEH1Kfo=
X-Gm-Gg: AYBFou2XA87Ypd95qB7chylvHAJ451y5IFDr+YWVwMcz5sw5Eiq3r/f9bi1AqwE1iVL
	6SPwx+MHshTskhKbO5O6DUVF+Bbz6gTwd7ctv5HBhkkCB2f1diJVg3iGL7DMkVmz4virJ7fAW6J
	nhePoILF/Y+T+yTB9yvdRjT5ikLXjtnXOskCG4rUW10ANuYxzdhcDmibmuWTgjl92K94X7baV5Q
	FLe9ZonaGLqv+uIe+GFSiZez7JCoEAZnEAfBEE8VM3NPw04b98O/XZIlzXurqLXfMqrFF7lJ7Da
	MqTuTq0LPp2a8+Rk5in7Z85ZYJCnxTaiIIJlUjgev26+0lVVvoyz2lOcCqJQCTn6ReBl64WsYVF
	a2RZCa2nidJ1aB+XRL5VGQBN4DGUksCzgo7mRk/7xlZ3UYTivI1Rl7TpECdnMtnSfiPIZjRBToB
	lcP+ZI7t9zfbEcjp6IBmFfjWnFanCs+0RGkYAnf6Dts65sKFeza+HsKx/bSWxGOPDWGQJquYuUl
	GyTY7rLdGfvfKCmZza1Kf1JWvUKaCGByycYW32vgoAgySExIi8ASJUlQw2c0/o=
X-Received: by 2002:a5d:6a89:0:b0:48d:eeaf:d2ec with SMTP id ffacd0b85a97d-48e3eba554amr11424295f8f.49.1793086642855;
        Tue, 27 Oct 2026 00:37:22 -0700 (PDT)
Received: from LAPTOP-AVI.lan ([2a06:c701:4778:c500:5658:786c:2fea:4768])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7easm21393430f8f.52.2026.10.27.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:37:22 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] init/bootconfig: pass init arguments in documented order
Date: Tue, 27 Oct 2026 09:37:20 +0200
Message-ID: <20261027073719.4010659-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

start_kernel() appends command-line init arguments before
bootconfig init arguments, while setup_command_line()
places them in the opposite order. As a result, the
arguments passed to init do not match the saved command
line, reversing the intended precedence of options.

Parse extra_init_args before after_dashes so command-line
init arguments are passed last.

Fixes: 1319916209ce ("bootconfig: init: Allow admin to use bootconfig for init command line")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 27f4cb392349..3a270bb96aed 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1089,12 +1089,12 @@ void start_kernel(void)
 				  __stop___param - __start___param,
 				  -1, -1, NULL, &unknown_bootoption);
 	print_unknown_bootoptions();
-	if (!IS_ERR_OR_NULL(after_dashes))
-		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
-			   NULL, set_init_arg);
 	if (extra_init_args)
 		parse_args("Setting extra init args", extra_init_args,
 			   NULL, 0, -1, -1, NULL, set_init_arg);
+	if (!IS_ERR_OR_NULL(after_dashes))
+		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
+			   NULL, set_init_arg);
 
 	/* Architectural and non-timekeeping rng init, before allocator init */
 	random_init_early(command_line);

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

