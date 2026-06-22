Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7B3B9D9F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139234; cv=none; b=iEAqyFCjQ+4aQ2PxDG5GnkweXrzuXZiYNljKhZKz6XHC2y0xYv+ZAulxojriswgwhtED7vEP4v9vTD42MoeCd83vKLp/b2HIlNJv9KrU3J/BMpgb1FBGcdyx/3OYMh+iuStlntMJENw+0c/K6npAZvDLy3Ei9N+L2Z5eZv5y7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139234; c=relaxed/simple;
	bh=k57m5verdtW+cYAgqm+Bv50nz66tCGZeMDwC9+XvQNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkvD744YiGPcc3WdQ8WYxXPy4+HPZkeSuGnpzGqfe0etvq5b/Zve29fWOxp/DfRKhY6gFtnJ+VieUsT8JuofFyFR2X6ODfanOgC+HiYxdiVRuxQ5nbNaxy75ZoNJgekFir85kzE2lDdcZUbBu1FjFzRd/EXDU6VBPOF9tiSCLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XITzEaKM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XITzEaKM"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8612812170so121096a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782139233; x=1782744033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omh0azL6m04g0E+rxYjGBpdnggG9aKUZbb7rxFB1PDo=;
        b=XITzEaKM++DmlfzDFljP2OPeJ3hyDCwekBjDP8TVD5aIynNMJPS7fcyXz5nHkVjApP
         Sh63nJEzUBZEryXj2D4vYexihZ319hB30fN6goZvvnBcaL4gDWHtAW8OxkdwN79/S9k2
         wlBr9SMWVYLsOl3v6PGAVUTQy6RFHl70dv/mSP+SB51zc82x71/BGG8PSNXZGiooaoh1
         oYI09v+nofFcVXKdCfow7T7BUgLm8RiQFkA8Au/XeKVvpKaIFi4ov9aHhOBzZORIWAVP
         yxsT9w+dyB0FaxLwOP6BS6jl3SWzyp8q1kE0DwpbNeXXOYsGkurXwIPBPf9ozJYAIAXN
         9p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139233; x=1782744033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omh0azL6m04g0E+rxYjGBpdnggG9aKUZbb7rxFB1PDo=;
        b=EK5hCXlzN8VBZgQpjOK9n0y/JoiXpoJKDT8KBdhTJ6VcmSUmFxl4IYI9EoDvs6PG/5
         W4rwrAtAoCcmI4GXvCRc/vA50VwjiKEc32GQYugxqAt5dG762ZexFUWtE8aDLe+KimbI
         E/GFz+IhaR22618RQMrpnbL/0FWB1AJsBoxg8fmSB31aPusYXUC0l/ALB5JUeZQw8wlI
         5kbcZrma6t6JLdAIs8W/MOIl69yr6DCJ97t0Zq0rLL5PPpbpfi2LN3siPSdYEWowPE+p
         QRyqJSw5KpMJha+hZj+JUvL++w423UtTrYChdt6AfeUiQ+DrYlHfborvXHKOPg1jnCo6
         kQtw==
X-Forwarded-Encrypted: i=1; AFNElJ9pvvVhBbwCG96Qtz4rKp5uwjbsaqB+jHphRsliCy0S2AHhY47fdFetF+uHtQnOlmMZBuJjlN1ggiRiVmalODvEvQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpFeYK7fgy7nGQ9UjsmG7GeMq6z/WlHNQ75HJfMLWwqJ9ZwDs
	jvq+N6P+/Iy1XBCeBuaXi7NBH5eQdpr9v7EyhaEKP2GUX20lyDO9lt/8AkYbcy90
X-Gm-Gg: AfdE7cnNEbL9gj+XO1w76ClT+rmQpm5MRYFXfAuJa24tzK65UF8MihbZIon8OadjaBd
	AuURAxP6b6tzl1/xdDTD3Vo/8BH5hGCbMo3WfYywAJy+fWR0AZcN8D+VZ1WUZQQKwRBrnfLJs44
	+ejacaY2OoKEJ2iJ/5cV3HsBixWv/ry2a6LWaZ3AnQOV1+Cah44/FvUA5joGYKV2AimgVhB9go6
	+wqdPeBmkc3Pr6QjkMB0d3qwDVtXhpjdmkSo464bFolXrrFyDQ6OLQ4tGzuyLZhlr7sQsE448Rq
	Kw9K7kLeHIqkeZB10JIz0xSMcZiCyj9lPNdHeyY8n9F1cnDnow897H0omNuhU1JpWCp/dPgycNP
	WJeqyjxuvXHO3SV6H3F2o75OxbkZNZ6BMtR2zM9fXC/Mdwrh+iCH0rk75vNZOTr74OF1glPNKhT
	VdRaZGO6j3jyPC
X-Received: by 2002:a05:6a21:648b:b0:39b:8b59:4ec9 with SMTP id adf61e73a8af0-3bd0a8c52damr556803637.0.1782139232667;
        Mon, 22 Jun 2026 07:40:32 -0700 (PDT)
Received: from pop-os.. ([114.4.214.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bbffc2329sm7711940a12.0.2026.06.22.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:40:32 -0700 (PDT)
From: Yudistira Putra <pyudistira519@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yudistira Putra <pyudistira519@gmail.com>
Subject: [PATCH] Documentation: tracing: fix typo in events documentation
Date: Mon, 22 Jun 2026 10:37:35 -0400
Message-ID: <20260622143735.71778-1-pyudistira519@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the tracing events documentation: "can by built up"
should be "can be built up".

Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
---
 Documentation/trace/events.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 18d112963dec..581f2260614b 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -1064,7 +1064,7 @@ correct command type, and a pointer to an event-specific run_command()
 callback that will be called to actually execute the event-specific
 command function.
 
-Once that's done, the command string can by built up by successive
+Once that's done, the command string can be built up by successive
 calls to argument-adding functions.
 
 To add a single argument, define and initialize a struct dynevent_arg
-- 
2.43.0

