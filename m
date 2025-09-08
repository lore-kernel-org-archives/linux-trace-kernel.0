Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424B1E130F;
	Mon,  8 Sep 2025 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297175; cv=none; b=pxDHgp+2JqEYLo8UH70lmXqdxNIWtTkMfRTyAriNowLivqHKCxoi/4apR9UJr3CKaviaRefdglQUHwjsKQ+CkgMdlEFAV9rWleKlK/HX08jr7tKLlnz+uqLrW0r0DFNPpg7AWlwoD6zUbB3qSL7c56l8M828qkVqNnsjBi8jags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297175; c=relaxed/simple;
	bh=3oGnWRstd/UVHJx79u10eGgbspDyUadPtUVoAviHh8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlAxNql/aPgls5Gb0FobHfLxlPvZOEoSCn+Ah93dKi4FZ4uD12nsQuPvMp66Zsc6jXMlG3IklnM8hisdirCfWYWmKbQKnBgPCPSJHHx+ii3rZ4U26/dcvnxZhuuUyejWLMGSC61B+J8+nEWxCYbHxOQFNwoSwMKIltE5bdQRcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfVafo1I; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfVafo1I"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7240eb21ccaso37789046d6.0;
        Sun, 07 Sep 2025 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297172; x=1757901972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2x1h6orz8+wGExapeOmhQBGgWXVchLxViuyUEuu+o04=;
        b=LfVafo1IXUyNaV4UzhoVSfOaprDPbNW4bGEMHKTU3ZSZz2fUNn+FJSBYSKroMBJFMc
         oTyFAjUTmBOF7DX0hEd47wAMU+ucjhsBmdhe23yw/Wv8r5VREQ2etVFPMz+UI5s2+hkU
         dDPm+81BuXhVEYdJDUcqOIM1Pp8wtwNIkyh2sEvN/hWW37B5zSkwd0+CBlzTN2EhDpcw
         lwKlvT3LurZQ9JzqzhQdpSLsD7P2UzQ3mEWUOM+Q7sK/zpzFjAXMG5+6EP7r+Olj8kh8
         IW0ZdwD3sVYtYH478ZiJUvdliiTRQczLz0BPUlyyzbA2Cpi7ajoLrrBAh0x9BIenWxMg
         1pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297172; x=1757901972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2x1h6orz8+wGExapeOmhQBGgWXVchLxViuyUEuu+o04=;
        b=P/6gMwqnvfA4NELX/0gq/IaRMY29VNCyzpg3BRkkM9DeRSA8faYdwQZNR++sHJ+NQ8
         Qy5JPATV4kemN6oHMyiCvUyVTuG3TAJH2IwAR9p6IUjQZyQNm3XtubQrkqOCdY2WAM8j
         RetDUWQrpi5bYS1hpBw77o5Wd0zE9RW4+7EXFrWVN1TO8ST+H75lWjB7/I987RbfxhTf
         7o+fDALE+4+bTqRAvqdc5R/v+xthlSXVF4XJ5TJ38xu33DMe7hqVIl5vrziXMV/4MQLo
         yciNyzMWROyZ7NjEYVasjLLB5mMJxSsBUS6rHiIenXqe8uaO/rurWYenBb32PS5blNiA
         FtIA==
X-Forwarded-Encrypted: i=1; AJvYcCW1q9r/t2WWWz4owlIp2FFxeLRfBhZKLTnOQPMQCJjXk/If2yrnYyHJPtrFHzBPWSKzj5li0SbM2N4S85E=@vger.kernel.org, AJvYcCWYeH0qliHCp4y9hwLxAHD0eYCatkRePJwwFfEtld47sSygqX2uMUe9RXK85NjvHoZWTtEYwbBU3dm7dDi97iP6B88k@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIuR5rZowlS0Bc8yQHoLauW/OXKIn+gGsdYZKfYbTNxMxtZ+Z
	nUC2eP5NojA5phNObtegyql4GOVRbdjqO2p53n4Q+Brv5kepYvtUuxEEPYq1zg==
X-Gm-Gg: ASbGncsIBfQFwJxt5FwF/QBFyNE/f2PxJz5BJ8NOdIAaxyrf/94ewqu5PJWaYzM/Ja4
	DSOiK7OtkI0rF3BVtoGuNssX7yskktdoAbYB4VWavoBFlV6RDs+9tJRT/0f07Y3TMQnVXgu1zHX
	A8siR9M8v8FWo2wYgRr+U62EdPauNrKJRtqrRjSCahe0WFvHV3oihFa+DdrTYoHycbok/3eAlmw
	GPlEwClBgCd5OuAqxaxyCBgUwp4P+5fZfIM1sdeccpvzgq7hiihb36WJ0PeqF3ZkZrcbMAaGFO/
	WqwPgMVnDvP5kvRwnbKCX9uidHl9K6PQvvRql0v+SLUTi1kawlntnlE2LDp0pImTquIDw7n7qMz
	x6xdXrMft+dTadgdunuA5H/pxgrVqpfAWHi72O2WIdu0VmkfsNLk+lIcFSEFlbDLwanUEYP0uGJ
	WMH+xQD8EJdi252KuTPw==
X-Google-Smtp-Source: AGHT+IErm/VTBUJedFUg5eywLLVow7XHdGUcgt/7Vw0xyWJ3PDtRd1czg7DEAmfWvOuT7qHnMMHiBQ==
X-Received: by 2002:ad4:4eea:0:b0:70d:f64e:d49e with SMTP id 6a1803df08f44-72bc44eb4bbmr119584496d6.23.1757297172574;
        Sun, 07 Sep 2025 19:06:12 -0700 (PDT)
Received: from ideapad.solutionip.com (wsip-184-179-113-83.ri.ri.cox.net. [184.179.113.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72925b87571sm79638846d6.6.2025.09.07.19.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:06:12 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v3 1/3] rtla: fix buffer overflow in actions_parse
Date: Sun,  7 Sep 2025 22:05:57 -0400
Message-ID: <164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757034919.git.ipravdin.official@gmail.com>
References: <cover.1757034919.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:

    *** buffer overflow detected ***: terminated
    timeout: the monitored command dumped core

The result of running `sudo make check` is

    tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
      Failed tests:  3, 13-22
    Files=3, Tests=34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.63 cusr
    27.96 csys = 55.67 CPU)
    Result: FAIL

Fix buffer overflow in actions_parse to avoid this error. After this
change, the tests results are

    tests/hwnoise.t ... ok
    tests/osnoise.t ... ok
    tests/timerlat.t .. ok
    All tests successful.
    Files=3, Tests=34, 186 wallclock secs ( 0.06 usr  0.01 sys + 41.10 cusr
    44.38 csys = 85.55 CPU)
    Result: PASS

Fixes: 6ea082b171e0 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d7..eab51c0c0ce2 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -131,7 +131,7 @@ actions_parse(struct actions *self, const char *trigger)
 {
 	enum action_type type = ACTION_NONE;
 	char *token;
-	char trigger_c[strlen(trigger)];
+	char trigger_c[strlen(trigger) + 1];
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
-- 
2.48.1

