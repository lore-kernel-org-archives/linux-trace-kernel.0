Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273D3BD25E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281692; cv=none; b=KCb6ULvF+265KDSkIYg0ZBry7oVb1sPcQjmjsSZYkJnvPK4RdcCm8Q5Z/97KL70aN0hvAmlsSg+YgEwStelLG/1fjAPArxCgrsoFzE2IboIE5n8wDsZT1dw/bVZunwqp2WYrXoFFsba1yvsYVVFKL/6jJZ31NaWaj466qKbppeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281692; c=relaxed/simple;
	bh=c6f01OsvTiyXVnZWo8PZotkO7JnabjBxlucvDk2sbbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA4VZt+SiF12H/cHfRwVdzgXC06UCBgqWZGMJSf/3sGCfky4DHtbsj2oZCkTQuTQldVK8UEdjLV1pDYjqZXgo/UFahN9vRZZOS/RIFmniNakIQaO0U+lU2MhNpoAirueYTzeDLIVwGT24bLFJlPrkWJV1RBMYSe5r4eRX4anrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=H07E0vD+; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="H07E0vD+"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d77b179b52so224685a34.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281689; x=1774886489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIpGiwlR+P+YjF46voPKMTMFtfqJy7FG3o7efUKpfWo=;
        b=H07E0vD+EJFb7Rj7CpD+riSDXztheoLAJz7gJHTfBQOt5mkC6KnZxa0P5Qtx+U8B7W
         xWdeblvbFUoWhP3UZApKDfnzYDq35+M8dkNJDFwpGx+HDQIy/ktFTsNbTla6P0tDT2Nm
         FONT01pV66JZlZIybBnvc7fqdIHaOx1Rm6d8BIZ2Ss9w1XcQGKYZFhulUfQrZ2xQQmKY
         rA2+HbrQRh0jg+Uz2ngR6wW7/HyAGDKG1AuZerZcWW1QD8CEUiD030sffKAYEMyGebKp
         o5eYdrsiL8EwhHUtmCLLhFNNndr/HcfG4cwzuUgu9Fm1my8sAW/8Sub7GAJJi+fU05pT
         1UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281689; x=1774886489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIpGiwlR+P+YjF46voPKMTMFtfqJy7FG3o7efUKpfWo=;
        b=C8xvnPTbPq9tY72+danG4e8PQ4M150JwektIKwBr+RORfmvJzwPfzl1UkawuXz745W
         xI231rD99gHbSWLhu0JqqWywyq8FM5naquWJnbQeVMS94tFpAy5qVNsy4q8jdCDtCd8k
         0WEEbhD/QAav3ywarg833LRZtTUEF2k+ywXCsUez4LtmkT/AxCWQbV1OqXOvqWWw9HBg
         h0GJbmQ0pAzOhvgSNilLVLorEK3GMvBwhjzJxrfqsghaZHlAnXCPMsvux8+FmFb3LKVS
         UOZ4ZtOpib+XSpMyQgN0aWei4pKA5j+oe8LryE3DF+9dcJdeTpn3w8XAL/+/39AE4qqs
         fwDw==
X-Forwarded-Encrypted: i=1; AJvYcCX20QpDnsEBfpkvnW6YlUbAAEgUlpdKiaCXPxqb+oIlUYOj7kedvnG03Cr1JH3yJvCOGLbeMuXChBnWK9YMKGZ/4BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBS3aKz7dg5hz+lsbsnEkA3BQbPYxOOASsKJhYhY+OXZgAgmQC
	djU7QyyDPRtps2mEu3FkmFhCzmsxFA/HOiGVNRYS+KENwxhbhGrVvJsJxvFycBCY+dE=
X-Gm-Gg: ATEYQzx87/9mqt6GRuyG0WWwSMbnu/7f7uLUEYdFWEBUE061bhlZ/jDQ7wmFUxVESsi
	BpEzgJHg9ks785BEFLXpduf5/Jqn/NtKwxJS6v9As4mIPvW8VVHhBRXdvj00bItJyjCwZqiiHlm
	ohm6ODfOLKQZPSd3X3QXLgXQVRYGgDT5v4nbZbRNvHk96asPZAs9tvCz/A6xFoa5ZNcQxNQuZyw
	D2qqws0rokkFjZTyrBAkYcko4mieCaaeEIkZahXUGr58aXo6BlGxnaOaI+PP7/c5BM98d+s2CBy
	gV15ld+wu5ceKJO/RVflLa1LDPYfottcTV56I5CEw87x0HXC5qNJltpDAy3Yo8PVLKHkzqFmIHD
	7I74sA9/g0ZRKBNdAntwHaQzdznrDxEG8H7DUU0KOBAvvCZWaG+IVgH3M9MdoVbTlmUpq3PQKtU
	ndUkXUYctNEx2a6wEllCQus6y0pxgFcZtvi7ZxtYk4o0RAAFOZSV/J4o0vMpiy0gvlYg==
X-Received: by 2002:a05:6820:199a:b0:67d:e8a3:4c30 with SMTP id 006d021491bc7-67de8a34d8bmr3475554eaf.32.1774281688978;
        Mon, 23 Mar 2026 09:01:28 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:28 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 12/19] i2c: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:31 -0400
Message-ID: <20260323160052.17528-13-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/i2c/i2c-core-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 02ca55c2246bc..bebb7ba67e30d 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -89,7 +89,7 @@ int i2c_slave_event(struct i2c_client *client,
 	int ret = client->slave_cb(client, event, val);
 
 	if (trace_i2c_slave_enabled())
-		trace_i2c_slave(client, event, val, ret);
+		trace_call__i2c_slave(client, event, val, ret);
 
 	return ret;
 }
-- 
2.53.0

