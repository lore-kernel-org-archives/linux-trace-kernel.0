Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6143B961B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281682; cv=none; b=Rq8zz3UFDnakrD6OwQcrhCuZd4xLDMr8fFYDs39rPdxNupvy9Rfc4CklpxNn5OdbZ/K0SIxC4n/glAZOgHTz30AFy0McdF0flEy3QDq0A+nJexAS91hxWdLo24IWbUB6L+T+eAGaAkKRuD8+eFeHAe7y0A09BOT5Qsm7SS61Sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281682; c=relaxed/simple;
	bh=HeUi+wJsj9zhPE9nwS7pT8jwO1enNKZcn1Eh8Ap3li0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9jc1d+59GOa7xXQteK3CKG59WWjkO6XAckToWqpsarbqBxZ/qTUYYpnryD5UMqNWgPnoHgdi/bSuuwcbj+sJzfDeWZTTvO7fiMrqtMBcVWBmXxMaFdGVW34N+vn+LETK7I+PVY8YkBASSRpDXBkef3YW/3y+z5Yb48/vZnYWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=m7oXvDCE; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="m7oXvDCE"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67c250b84c0so958224eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281680; x=1774886480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mObnim+O/1qM5mBF9TW6/nMqNmbffOtpWCv4mCo57ds=;
        b=m7oXvDCESvhVKPwFSeugQdvB2miVjxWrknL3LJj+MftYi/oraJ1LOjx5pi3gtfpTPj
         H63Wh54VqZIFlP7flRye3InTbx24326iMj2LWBBHonkvkZCslovyVfgmkxzgwLBUxQ87
         pL0GjrJx/yr2KFa5nrDoT2X8RRJWN1GD7BtnSurWQ/Pal50+rtfplkuNb/Jh4UXYTTxL
         3YEGbqUqNyn8Vc8atG3Ia9iCVKPSys7saXNO8kHJ1z4CrroheF1chubTjmCZTw3ASJvu
         usv19XM9+aNw84fI5DkdYWZ0e/IFKPyu9T/MeycdYtQE1sbantKDoQ94dY7eBpbb099R
         r9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281680; x=1774886480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mObnim+O/1qM5mBF9TW6/nMqNmbffOtpWCv4mCo57ds=;
        b=a6YoqiJaEYd03SWV7BDY9qxRjn2wOOc+PmML5RNUDSb1ltYW4MXv5l5JrwNYt/EEPR
         RpE+megOi71e5fgB0a+AYU8dsfvODJFitX5teCSUZ+wZgdWloPPCPu4gD7dK2yPGY1A4
         eHZHxBecg4vOKHPC2g9h2PVGCo2vx/JgswvlwH/nibx5fuRQVg1VW+bWv4S0bYP96i3s
         ASWyyxnNw6Zhj6m3zArJ3gNY3yesUASFqjItUFskKB/lh7apd81pWgAkNlLsZJcKF7ck
         rnbWH+cLPeeONKKJDeHmuWR7JgDaS3tECdo1IT0JKxoDgPmwXpG4hjKcq0FVzt6qdj+G
         4l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnUjL1X+sBrNCwnGmLwCJJxXlji3EdJftJ5ao1XS+06KZqqP5reAuGrIw1RnxWv4OTEJnh+xe4PPFsq5WsutX/H0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzHUfI7vIK6dPboevA+feMzqz34QYJ3JwKHUuaZkbfxvPjF27
	xASZW46rbT7dHs9zNmRw/nOwHwsrbpLEo1hwpf8OlG3KaUuhylZO3au5bgttoV2p0nQ=
X-Gm-Gg: ATEYQzyaoLqKn/J2xwGwWvf4umLfHwt+rdoo1MyDaDZrX5FosnH0wX7H2mAU6Htud2l
	h26Syg4F8VfmVgn153LYXwEdj2ZpbZ00jJxYQwB/RjiVrTuJFP2e7X6zwWkMuEPtUX2OmsK2cHg
	6ERUOyu398bLKkgN+E1Jm9FcV/TX60ogEw5Fxb4EBZeDioXOxgK/iSSLmli+d8XTsk5sgwmJLBv
	NlJMUziTLRBDKI2vyjE3+Y18bC1QxGIWt9kbBDb7fa5rgrIpu6UuxNO/F8PXyfVFf2iO4rE1c+k
	G04jmPlIwYgaUTu6/wMvyqZLQfVK3HFnVIrYxiuBfV2qgtymDjVCFLdMVFKO7IcNFI23NjyMkgf
	zk5pjURnOwewij8zwmFjsIat7eXfvbkUrA4skqqu6NlzDxvEKOAAHoOOPvlVVrZVPNnTfXlty0p
	qEiSzGVSlDqjPnHkzVjAi8n+h8eW1nD+B4ZnhzZxbi9wFZjHQKDqcBHVMGz7d4QmuwYA==
X-Received: by 2002:a05:6820:987:b0:67d:ee07:32df with SMTP id 006d021491bc7-67dee0735f2mr1955626eaf.23.1774281680005;
        Mon, 23 Mar 2026 09:01:20 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:19 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 09/19] fsi: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:28 -0400
Message-ID: <20260323160052.17528-10-vineeth@bitbyteword.org>
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
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff338..8313c7d530eb7 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -229,7 +229,7 @@ static int check_errors(struct fsi_master_aspeed *aspeed, int err)
 		opb_readl(aspeed, ctrl_base + FSI_MSTAP0, &mstap0);
 		opb_readl(aspeed, ctrl_base + FSI_MESRB0, &mesrb0);
 
-		trace_fsi_master_aspeed_opb_error(
+		trace_call__fsi_master_aspeed_opb_error(
 				be32_to_cpu(mresp0),
 				be32_to_cpu(mstap0),
 				be32_to_cpu(mesrb0));
-- 
2.53.0

