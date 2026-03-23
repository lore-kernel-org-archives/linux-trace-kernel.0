Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817D3B9D8F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281691; cv=none; b=sk9dgxQDp/S07Ptev7p2C4UqC3Ihbzv7xFDP1/L4ghfoR8rYhmRmm5I5BCCXvH4dHCXxRgibhZmeTadc+1dZtAFYgpUWTY7ZaFNd+PRo3uU/S56uckkxr+4D42chckJWo6HBXW1BNf611ooKJQr43sQD9wEMRgOPKOA0kSVbdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281691; c=relaxed/simple;
	bh=LmRSwQX52HdCSQ6DgmgIrFMSbUGlSX08R5zAJjefNRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT8zFO80HOcT50fEia+qGF91Du9tTjyDhYAedARAJcZdFNisvdXJX+w2h/udnJi5x42ABQlza4iM1roJtAkdNZoFrU405+ruIOwlb8WGwzDy+TFB2rzO7+8FbanVcdp3keBuDV5cm8Nhx0LIEqI6xuZoOOcsvyd5DQqF2uUPPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Yvpef8nc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Yvpef8nc"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7982c3b7dfcso40494087b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281689; x=1774886489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgN/E5MstV8O0ZehCwcajMwfgG6bTnMGl7IbsNbuSbg=;
        b=Yvpef8ncSCd/mgYgKB6DDojYjCqUdSXzm0Imxo/VsLFBrKTiZ39UcRbhTlARyeIkeu
         zqiln+ejCXT6pcaOuyLOK0Kn1piVmM8gKaB1QP6LJ/f2yVn35uLAK9NVwrkYmNuhrQRQ
         ckSk/w4EqmdE6YtectdRdWmqTqyc6LgHiq/onmWddp3WIW0uoHlDc0J8wexbkmYmL9d+
         omBSzmgqVEQBWpGfxQBBb+O/ro+vUqR9Qt/4piQICffiXSQR3NqL0Qu7Q1fzOfYR5fGV
         rugc0aj1/S5Cak4xRlTwUVTIDNChsAn67nu8eTIbv2wJ3HELfPmqHW8WRiggspNGkg/b
         c3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281689; x=1774886489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgN/E5MstV8O0ZehCwcajMwfgG6bTnMGl7IbsNbuSbg=;
        b=HWqNLnXodmC3oDznz2lORkbXdnW/bFUPRmRHQhhaijDxIM9mP9L/GYWNmITQ33SlvD
         ybsf/SzmhoTjJ3rzcmD61qbTzVyioVy5C+Rc0rJvdQIYEn90RWPy/48a3b18O27XS0Jb
         +gLLYDpr1/siOMQiFRstcgNPrWuy4+GFfs6jHBnK9vYUkTImWJQUk2eT4EsyLOqkrigC
         ncBxlf9b8k6X+MG6wOJXrfK+NZAx4A1CkhRzrxsZRcINLx2fMuSbCxAck/RMLOCF9qUT
         q3c7Hy7VbDkh3gxikEXVHVXiF25hSq2LtzXiSDLH6SXzU+FWE7sync93g6ah+Qgj3u5i
         xkMg==
X-Forwarded-Encrypted: i=1; AJvYcCUKLV4iqf3jXRc3GuAiwK0dtIXFY8Hk3VQyOsqMAHYy26dmjrDIC//qY5s6M008zcIP7AqM+jf4R/nxByC5pnxG/HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/7dxgioTljkXSi9H6CHu/1S+GkVkV4eCbqKCS5EGCLWRXxy0
	bsuwi7m1sR3WbxB5uMXrM5rFPuRaLVnfzLzB0beVbVAlOI+Cw8YFwVGVN74/u/9gM6gNPtSeT80
	ZzuZZjhd/Zg==
X-Gm-Gg: ATEYQzxdzopjti88qNfDWIX23GTVeeEujk5LF0DNrKFekifmZunwhg/B5ZaAJpbQ0tA
	nGteU8Y4f7bdUds6meovSJRArnK5wFooR2aBGcYW7d7pYrL2ewaR1Wds26IDRMTEUN1EqFwHHYT
	5kIazS7SBv1XmpmAsMkMCZ542FEmwRS3JuY9hqOtrptCYi8pmT+SIb4vtRkWwlkzFycD78+WUp6
	ZGt/mUgV+Rkvtil+09L686MDqnGCdVrTt3rVtGRzUIRN98x5TtNvUhbLTaH4y67U+sYRilXYJev
	yBW48aDCF6XOPTgOe7rIR8Ss0KOqlv96h5YuD7yQQslKvAgBaLE9hRqUNKVhCYujIASQfV0e4YF
	1Fz/XxQvTNulbLTnsB1xBECt2KjppZYSBmomDshp7kyzpco3L2EMzvWbROS42rH9Wb/iImwUWvY
	+lVscEKRYP6WW/riE3+H4ABEC6HJ1qjBmO4/vAelCq9xAFcS3HzAEmKGHeZvmz3iJZ4481JxMhw
	ydn
X-Received: by 2002:a05:690c:d88:b0:798:7821:8b8c with SMTP id 00721157ae682-79a90c25bc0mr126905677b3.49.1774281687685;
        Mon, 23 Mar 2026 09:01:27 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:27 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 11/19] HID: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:30 -0400
Message-ID: <20260323160052.17528-12-vineeth@bitbyteword.org>
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
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index ed3405c05e73c..8d36ae96a3eea 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -110,7 +110,7 @@ void ish_event_tracer(struct ishtp_device *dev, const char *format, ...)
 		vsnprintf(tmp_buf, sizeof(tmp_buf), format, args);
 		va_end(args);
 
-		trace_ishtp_dump(tmp_buf);
+		trace_call__ishtp_dump(tmp_buf);
 	}
 }
 
-- 
2.53.0

