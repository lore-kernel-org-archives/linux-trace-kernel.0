Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9071E1C11;
	Mon, 21 Oct 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506304; cv=none; b=eJ2Qkjlh2bvpz0TtupCa3Fp/ua7X2QNkxeZLavkgMWhl2+GCaYbvbh0GUB48BbWDaE8g7oOrIY3d5GbYTA/5IDlm70D3/JZ73YWdDOcmb+xiJ4RLZvgEYo6oU0jY/3InFL52DSFmciGe5N3O0mTEl0LOX393FOvtuQLGLc2Wo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506304; c=relaxed/simple;
	bh=KD9M1VGnNWT2jlHW4Y1ujgavmnn4/lXTInJPOGU392s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiM4Fby3apBPFXoSi9ffV6YInT4vkVxn5aHUs2NU0zOh123HG0AXfttgddoRxJJBuwiC2IuOdZeSPJXRgN46PqJpRqxEhnFcbRhqDfiPLnLbhhO/x0MmNTZnRnKpvvOR+2hrtbD6e/m0x+6o/KpBCBmqZXF6ihB94/NGuSAzMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuEeWO0E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuEeWO0E"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so45391445e9.2;
        Mon, 21 Oct 2024 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729506301; x=1730111101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAwlhGQzbSLoByA/ARxTjenPoWKomOS+mOggtCmqFeo=;
        b=EuEeWO0EFyGAkkRU0pVqGLqebR9A+rMv4McZTTmU03uPoK1GavRGKDPhYJsAQxZtju
         o2ZaX/ty72Hi6yRuJUlbrrJezAHnJbJSJtrohXJkXiRpHQsSJowhWgd02dvbLhBdSDYB
         +IqTd7Ors8Rq0Vog0iNEUpGrdQFPRn3N0DQm1ta9QEbT6XM04Nci+WRscZuiG9Sgzc/r
         Ql6cj7KYsdPTVejyO/cw6fvWTpbkfIjEv7l07/nA42QL3iUeSO2zY3ZyWMT/vEH6DqNB
         lFrobzV7awtN/c3ijFzzd5GfdiA7w36YiPY0RKGmSyNyFjfWzhxMO1kqy9aVuIR41Hvt
         W/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506301; x=1730111101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAwlhGQzbSLoByA/ARxTjenPoWKomOS+mOggtCmqFeo=;
        b=EoMcvyJjzXI4K/yVZ/AZGJUrs7wKKxbjTUytOb/enQLz/HldYpVKp2aO67ZhHb1EK4
         OvHWWKiwVAFUmxa3/C3o2a3l/p7wvH8z3VIw/k7umYJDPIazh9iJHBheOEjApbZyiv/8
         9jamxINN4W4G8CmP0bUlT8rwc5zi0W5rmV39O3diNfY0YA+vrCehp8xlb1D22S0SmiZX
         CMWvU8kxVOWlTjtNucXb7E3MBSXVZc8E5CsHK34dKU15jJmfmXbftWti55npXtf3kWuE
         2uHX8BEkq2SaFDX1xRHlxoD2usLB85LsleDaA0V0FKFrVhGBE8H2+Elepd68ZFLjMoXs
         tJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUnloJGHbAjyeTqGnM1j2IGBL2X+BPJ3i1dl2q7zY4ZVjsF8wGrBTBkiHat8InjKKfkob7RuAyXSh2B5MWgY1+c70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQSY0yt8G/fyiFi6U6zwlfuizXT39sZ9XQAbEOOQAcunP8udu
	nZztVrMbIepSMpqETXEXUg1mJp6+FJF+UWGpAA7rB4fz+CAWf9xVrn9iu4BzFWY=
X-Google-Smtp-Source: AGHT+IHvZKAo57+wfpvREVx3okbJ9A8oAFQP2M2WMnLoWssShO7pbdFvZWN0MzFBdqS1iwDl5Mkfjg==
X-Received: by 2002:a05:600c:1c85:b0:42c:b3e5:f688 with SMTP id 5b1f17b1804b1-4316161f338mr70928435e9.4.1729506300709;
        Mon, 21 Oct 2024 03:25:00 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:ff60:75e8:cc8e:6028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cb88csm52269085e9.39.2024.10.21.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:25:00 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH] fgraph: fix unused value in register_ftrace_graph()
Date: Mon, 21 Oct 2024 12:24:29 +0200
Message-ID: <20241021102428.287998-2-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity reports unused assignment to value ret. [1]
ret is assigned to 0 here, but that stored value is overwritten before
it can be used. The overwrite might happen either at line 1277, 1290 
or eventually at line 1306. Therefore, cleanup the unused assignment.

[1] Coverity Scan, CID 1633338

Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
 kernel/trace/fgraph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 41e7a15dcb50..cc2e065c1c8d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1262,7 +1262,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			return ret;
 		}
 		fgraph_initialized = true;
-		ret = 0;
 	}
 
 	if (!fgraph_array[0]) {
-- 
2.43.0

