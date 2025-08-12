Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71892F4A07;
	Tue, 12 Aug 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019304; cv=none; b=lEqQDNAKmaIvC6niXQ9rki2XAwsTHsnPRCOAbiA180fYAdOuz1koz0hkyr5RXhC9WhAq/pK/pG6H8s3lolKVuDRD+wHOVzU1yC00FayOLG7wgz/dceKCrxkcw2zfYdsEgWQ87tV99qezmvy5nV/SHu2oWfDJ+FndEJBqtLWy8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019304; c=relaxed/simple;
	bh=sH8ZhJxjPjK/W5fojUbfcWKAEcP9xOolfJwD3H7oH74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sm5YdJBTBRj1CNeMdCq9LDa8+/BKwUGc+vlHrriDlYgLJC7OqjARKErsbNtF92dolsn7ooN839+a8SIq4FgHgyVNduJfxMyWq0ZrpM1K1goZslfjgFVba7msdqcATCGGZFUuOxI21pWfN03CiRS8ZI8dCWUp+CB+4Gjq0K/3G8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XljIEBWj; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XljIEBWj"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e806613af8so662680485a.2;
        Tue, 12 Aug 2025 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755019301; x=1755624101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM8pT9HqxyMa3H416EZmlZYSb6JbMTeAfDZVPtYuWGY=;
        b=XljIEBWjq98e5JYMKguu4Kz48nZauIldiuv4RmV111srg+tYd0gafjkprconchQcQm
         jVoYsw0f2b230TYK0h4Dbl0hen2zhdqKTlmFt1qAnnlP52peK1460Wl9bxpodGtfhL0w
         iMkPUOyVlSYxfyoPmb7PKC1FCbRSaZqqD6QEUFLwDHup2kFxhGStXeNwIBQAr5qRf218
         wL4aA7niCUIYjsm2U4si+NBAmuddMe2PneYqSyzBxw1G18wP8KQOAsBF7+c65OC2TYQA
         YEkWq9P27aS4lxDwUnjTOYdKSDJYoJtmhC/IukWdeyiJoy/Tldgd+oTISp4D9e7nsjRD
         yj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019301; x=1755624101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM8pT9HqxyMa3H416EZmlZYSb6JbMTeAfDZVPtYuWGY=;
        b=e+e8ZwevUd8khyVzoUGOcdch4nwNLDfNbZSCqCrfJXy59WjqHB7GdCUFTeSuiW5pql
         /V8ih8FxHzUoy8NPdvAJ/yKX7DiHZ7ico36/X64SRx7Q1QG9I1saf401MQ4nbKgr2jeH
         ELYmZvlmgEXcOUP1WkY4zrZMwGhqdAr7JU54zpn9adFrNyy7H8GcIUlvQyv3YJJAwqT9
         BVmBWZ3DfWZTNtXUQVEyO8+Q7HgpkRtmf+sNwcrRsc66oOcT3wZSRvhBPpFlpOTFO0yU
         cdpVXqHeqKayGLCNqTFu2VQBbA99/g8kMWhSyG5P3Wv0A3DgAp4vlgtuk/VkrxJ1Cfau
         +wlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/+M1rEFgPVIN6yhUIc88/JIVI4wQAz7DXnwW/7Bt06m2q7y9P47bgffPFtJ0i3C+utJHTgF9VnKm/0o4HSY9iHT4u@vger.kernel.org, AJvYcCX2r9xHKzxW03vhfaGm3Yc3N86bKz4InFfMJX2wrEOn9c0eU85siQ5aNIlljE46XRGAdVW2U0KM2YAGOXg5@vger.kernel.org, AJvYcCXZGsB9sblN3Z96jk+kBbu29HSbDmCvr7QnFl1pmw5s6pWl4SllIvEQtkgBy9Tt6NpfF7Bzdr7Plf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJHFyqE35xKgO9h2khEuy9Wsi/OQReayA28rXdnAWiy87SvrH
	GlrR0eJZSUeCrikUxxsGii3BR+6pbUZpLhyhdg9JqnyADBHC7lH2skix
X-Gm-Gg: ASbGnct2Hb6NBElx/9yoHXaaGJ+jFQotRb/1YwJFdJd3PtizOQW3Kx0yM4sDLED/3at
	McjeMMOF9IvcuimuuBQPQyAA/cawNmK4DdRI989fxzFcH/Aot761OKmiWrSWVidGrHjYMnDO8Kd
	1EgfecOITfNRElyyuduE0oz4CjqVPWRy+iVuWrEalRHOORRpGVuB2cwspDE9DYoVFxhvp1WmwQx
	A9yaz9hwJel+/wBnBE1w4k91aSiBYf7bMDrobTVFD2nmr3BlhBrm6DFHLtC4KRBumY5LJNYbc3H
	c1xAonFfGYDeaWfn43LOCT257vhjp8VKvpuNrVze7vkb4AhvL4erRwvt4FRlBQOSHRkKTXkG66h
	UkOD+H3UwW4KzSWqAioX734tAqjrnE4TiEzu5f79wQTm1CKXBRYfQluFF7NttYLA348sa28iLH+
	/HPB4CK4mKQjVa
X-Google-Smtp-Source: AGHT+IFEw8r56npI81AcDYGc37RChY9ngq0KS6ptE8f5w0v/CPHg1XJGGEBnL4aJsNDXUzKjPbxAjQ==
X-Received: by 2002:a05:620a:59:b0:7e7:ccc2:67d5 with SMTP id af79cd13be357-7e86463301bmr61867885a.61.1755019300564;
        Tue, 12 Aug 2025 10:21:40 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a1ccbfesm863457285a.51.2025.08.12.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:21:40 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v2 1/3] rtla: fix buffer overflow in actions_parse
Date: Tue, 12 Aug 2025 13:21:07 -0400
Message-ID: <358400afe299a82806e9969570cd3009621bcd8c.1755018581.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755018581.git.ipravdin.official@gmail.com>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
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

