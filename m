Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0A35946;
	Mon,  9 Dec 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749608; cv=none; b=POjKsmJNOIRu0TCgjUat2AqLKw7i3Ucq0q5ECqVZGXAODF59WUoK3SGk+xh/hbUVUkW/yNVyKU6mMyw4xPt0QHzVXxxraZJdiwX4kCusfrSnq9BLGHB0hvpAJfMa2W6vAMYYTYp3xz1MRnmz7H9iJvtCrcaVPvPh9k2yRkB1oHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749608; c=relaxed/simple;
	bh=vliuzW6oAKlYkynRr0BoR/o6IsO0AWCo8TwCyNGPfSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbOdjlef3ooSmOlM86T8rxuMS0et7uB1D4djsfDuoz85UnUyezKU6nyBXxwS0GSts4ar0PJBIDyM/0upC6PD5bMiuAIOdwTz9FpG9NpCjaqEEUmK2XkjaEBrGRdV5U4QJiTahpwd83CPXlRMUMOhNoJ8rgOe5q83lhF73R8pmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZBnOK6H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZBnOK6H"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso1692443a12.0;
        Mon, 09 Dec 2024 05:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749605; x=1734354405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtU6lwN56MGWuHArATgDm595svxW7Y23jzS1Sw8OpFs=;
        b=SZBnOK6HtIZWRZQmk8M5nPmeUDR7bc0/R27tXLNqhmMsaAn1j8xRbFqnxqQdkX2hix
         LSnaCGxHPGbFDVAMoJ+BBqmcOk9l3gk/+iZjM77QfSt2WXW0cmJLDhkFP8rKDtWkY9OO
         vbXWY2Rzw6A3n0BJz1AOw7qea9qKH7BFX4ea3J/DbT8Ata2PC7p5s1ICwRQd5JHoqRx6
         nv0F6HBC8OaII0fy2tkIWb84aJCe2W1CZeVlv0dKGzBi5EsS3IkIbuoUUEioAgiAsyJ0
         JDA4iPsm5RGvXB7Jurw5Y7RauJYOdFJscLtXi8ufemCu0RqLzt61gxKLCzISk02AOHVz
         Gieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749605; x=1734354405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtU6lwN56MGWuHArATgDm595svxW7Y23jzS1Sw8OpFs=;
        b=uAvDGw3tXUTWZAVMYwK7pfmE4DE2MYj9CCSmw8pKR3qR3pMHgp0RExtnoCXUNUeOZS
         AEjMMa72L81db5ZMFr38oFOcbVsPBYuvQp3i9MPPDh+ZH977ImXvsFmxrDxI/h0TQYu2
         zJiDEzM5CIlwYmA7FzyGAPV5RLVaELQXU0t3Pk0QBUegng6+WD2L9l/E91ewtgHNQ7O8
         Kz3Uza6wKAtNYEZxvJw+Fz+P+np4uYqUD61LGlitWoL2DLT1CUtB/w/FcYytbiYDKlVe
         R5nNGCsPB53fem1cHCVZqB5orz+yPgweK1V1/uPnEG74Mwmb0KZLPlcISH5bWvnkENs5
         wOdw==
X-Forwarded-Encrypted: i=1; AJvYcCUBKtM778/JIhXWBlg4NKW5VOYO2FApwIHRMnu+/0rM1IGZrxxxBPVV/LChvt28vxhNOO353siGnQLv@vger.kernel.org, AJvYcCUrQ1yILx6fdSpPaX+6UIw3X6B5iRrYJeyAXPRWNyk0Wl3Wz0BPxozFoqxV4uSs8JTI4ZWAKI3llN78isCJ@vger.kernel.org, AJvYcCVYl+cqVnzjxzIlR3mYYi96zW0lcRuahGZLajNZ7s7uWR3lXyOqR1nhlOCRwkJDsuomvSc+kZ2feCA0M++gY2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhKVjxFYK7bxWWWcWHvYp0xj64kdkB/nV8kqulWDwwwcX1uke
	ecGTbLnr5G2riu21ce2JoV/WAB67gDrjaDy494q/dseuiBi83bUt
X-Gm-Gg: ASbGncuDggwXTTCC4TSfl2P9AoJ1O+ggfN+DaUIF2TYhFG7sEEoay1jQ1GbrVtaxeFR
	QPBynUvNvnvjiP4QJFS3XdsJKvdrhANMbUK5K18wjxwWRK2sKijSq8NMQDQNTIZci7W1Md98a0g
	PxwVbNTm1aAtElVfl1tUbT1z1kb7UsjibyyS3bf0+goK1kXcjTfvLm5f580kkZv9SUrf2Ki9Xtj
	TMET/ytIhIrDODTLOWw9AGOIEBhiWapnhHIFfLwBfI+
X-Google-Smtp-Source: AGHT+IFolnwhrTjnrkMfdsTj+uiywvUme/yN43zr+TfUpb2BoksT+kHM3ZURwBzqJH3RdHTrbAaCkA==
X-Received: by 2002:a17:906:18a9:b0:aa6:8a1b:8b7c with SMTP id a640c23a62f3a-aa68a1b8e98mr257608166b.2.1733749605171;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
Received: from void.void ([141.226.13.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6651c01c5sm352412966b.23.2024.12.09.05.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:44 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] Documentation/rv: Fix typos
Date: Mon,  9 Dec 2024 15:06:00 +0200
Message-ID: <20241209130640.10954-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.1.404.ge66fd72e97
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in the documentation: 'a' -> 'at', missing 'to'.
Fix them.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/trace/rv/runtime-verification.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
index dae78dfa7cdc..c700dde9259c 100644
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -8,14 +8,14 @@ checking* and *theorem proving*) with a more practical approach for complex
 systems.
 
 Instead of relying on a fine-grained model of a system (e.g., a
-re-implementation a instruction level), RV works by analyzing the trace of the
+re-implementation at instruction level), RV works by analyzing the trace of the
 system's actual execution, comparing it against a formal specification of
 the system behavior.
 
 The main advantage is that RV can give precise information on the runtime
 behavior of the monitored system, without the pitfalls of developing models
 that require a re-implementation of the entire system in a modeling language.
-Moreover, given an efficient monitoring method, it is possible execute an
+Moreover, given an efficient monitoring method, it is possible to execute an
 *online* verification of a system, enabling the *reaction* for unexpected
 events, avoiding, for example, the propagation of a failure on safety-critical
 systems.
-- 
2.47.1.404.ge66fd72e97

