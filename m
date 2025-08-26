Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AD31A55D;
	Tue, 26 Aug 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225012; cv=none; b=rJrmpzyHYUx76Sq/Lv5b8UBWNKpoV37/Z3DGsGrqXGicBxnHWLJbJPgsaTfLbLQTb+TxxKhqi3usFbY73mtx5B9F5n5x9neLKAZ9PWa3Gfpn0ktwaPLBJPJ0JRvrogyyI7mdA4wrlNqnCCwX1gfXsZfwsB/DNs83+SD1UoP8qEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225012; c=relaxed/simple;
	bh=gPqI9UyQeX3oHqtA/lKa52Y/njo0Nx+KOfMcrKILs3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NezF5+EHNb9x6f2Qji7uo4b/FJBmIe54+IVm+8+UnDcvG9sSXWFBjE0NinJUAHw+Cb8qWE0KoqaAA2wRf14wLNEnZvLfFzlQjR+rqwiKymOtlLxRAM/VA04+bfADewyAxcEKmgtqs7m9Y4XQCnJnkdlSFA/ZyttD1KbC/u1FVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz+gF7qq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz+gF7qq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b618b7d33so18984935e9.1;
        Tue, 26 Aug 2025 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225009; x=1756829809; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zZ89Yhb0nkZj5s6/rDGx+ZkKgCTweoTkSJp2qLrbtQ=;
        b=Zz+gF7qqhCTEL/jm6MF/UgqOx2RVz1JT+I32xeO3x+61Jp0+k40ftL5CZ3JvncpqdF
         +5I7TLshqInPQd0JL86glz8aSkmc/epESuYzlYUrGTxdzYmfIBLIYecjju5vaTDxF9gg
         8P5gWKMUe7EYzUFdZaqdni/wIiKdG7Bmq1StdKgDYXAWngITbFMCYRv67t2Cog8yjJdT
         fOTDAlCDCsiwijdtQDf5HpfFJJdVyqh1S4bP2t4F1uyONBkNofQqkzD46n6co/CWkrqU
         f8/WwLlB+00IwOUDTtWULNcAHdZDnGCZW38dkjkIrbhjnx7vi1hSu5i1w0vJqbtG59C6
         AW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225009; x=1756829809;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zZ89Yhb0nkZj5s6/rDGx+ZkKgCTweoTkSJp2qLrbtQ=;
        b=fnrFt22O6gtAHOGibW7IphMfZS2jNlwc9sBUSk7E21Zh0afFWJelXltUJxYwwwCURP
         i6wg1Ni7bbITmS1gTVfjo7lItKN61PrQbvp1662EifnowdbOlT7Ec3zBsgFGqqc1ijNc
         09JTGJ78ZQIlt8tLR9hH660B5uty6heLTqLE89PcfxKzB5K7jN8WMss1TXnpwL/W0Ay8
         6f0HafzilEBHuavP3qvnEEfg+RNeKH1+IfPXRR7CJCtxhzqthbR5jgt3NC9oH7I4QG3u
         VJNEqsynTTt3tAU1IUWFXk86qFPDKcxCz16LsVBIjKvKL76QWHECtw3BfMX+fFlIK2ZO
         D2jw==
X-Forwarded-Encrypted: i=1; AJvYcCV5IYsKiL+WAsRpnBXUqn4KHaJCizD2nNK/lOJYq9HFPe1JJHEz6D7z/O/Sae0ER52oruEblwwVTR0Hb/k=@vger.kernel.org, AJvYcCX84ycs4/UVRlxDZ/Xl0NOvq/I4XM9xtEJYZgrC8OLiNlsOZkHZt5hgjv1WPt/6RJYDjU3w4FpkakpiJPN/nheTUMzz@vger.kernel.org
X-Gm-Message-State: AOJu0YyyX/DgnmSoKTWCGKumJxt2RL3otEUqOOyWA+9awEhognrSCZTY
	ZnrfiyGamgk1nWfDPckpl0ifgVrPp8lwhj5+aJsOBkfGbJGYbxl4QzA=
X-Gm-Gg: ASbGncvfAQLRu/pEdpY+EgvmtJE80ewGhh+3/ol7CaXbCP9s7uz/ZYFKt/rxr1PYBev
	SKs0yHOMxaoFaWIDXgu1Lgd5ytrSW3X4pkG9L+nuZP9Mp2tEa4VaMQ76Kapuk5g2DmqSbA8lJ1k
	hf2qQdr+TWNGI3XZ+V05s8S46EME0BhBEjcGFdViWM0gL6H3Kna6wJNFxpFKGns2jv3Vty72Huj
	C/bdWe2mPcyu1kxPwjz9CudXPQxY4yzhf1/9E0wAywjP/Rw9wIWv6E2idAuCaFJGftGX7HlB62b
	7wUUIqdKzAKKvo88rp/qDTOhoeOgMgoSQ7q8rtP/NopjFlJLn7CqWP4h3/t3Don3ldnInkLrY0T
	hFDXxWRgjm2ga3ien7DTOk53y
X-Google-Smtp-Source: AGHT+IH1Qd/Cg1lHdtOyIWfihrT3Lia92XnA6mJiXXvQK0U3Bvy2DESu+60TpXmoz3F8UyjzGSgGDA==
X-Received: by 2002:a05:600c:5249:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-45b5179ce4fmr126400825e9.4.1756225008871;
        Tue, 26 Aug 2025 09:16:48 -0700 (PDT)
Received: from vova-pc ([37.122.165.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba41bsm17752521f8f.10.2025.08.26.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:16:48 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:16:46 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace/samples: Fix function size computation
Message-ID: <aK3d7vxNcO52kEmg@vova-pc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In my_tramp1 function .size directive was placed above
ASM_RET instruction, leading to a wrong function size.

Fixes: 9d907f1ae80b ("samples/ftrace: Fix asm function ELF annotations")
Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
---
Changes since v1: https://lore.kernel.org/all/aK2I2IGKRwmkQuIR@vova-pc/
- Fix commit message

 samples/ftrace/ftrace-direct-modify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index cfea7a38befb..da3a9f2091f5 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -75,8 +75,8 @@ asm (
 	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
-"	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+"	.size		my_tramp1, .-my_tramp1\n"
 
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
-- 
2.43.0

