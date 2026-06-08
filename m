Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA0282F30
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884454; cv=none; b=VKwxUkJkS+cJHPNXpFcIXdu4qGxv0zyq/0Zqox7P46JNNv2dYKO+p28oMj4vYufdd8/EVcKjMmiwPL3q3BHYV52Hfte8qPFuGTtmZltPUxzvv40Q+aIlTQ0jz54NF5zDkTJvZ3Fi0g2zFjpAI8QNwPIprVxNSdWtbWri47TuSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884454; c=relaxed/simple;
	bh=cPstpMvfPw9QP9MXsMENPNSR7V9hRvHvKGadUXgWrws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQS4oRolnRwPfceJ3uY0x6M2HadwK3sWpT+rJVA1t3p0f70SRiMNbgXGzAreded/8yCQJBW1mrSqDbP+Qy+/YfU8BCHNfgsJDIVbffNSVZIAUN4MASeebuA1Q4prUNLdnE8TW1EDINKNrdwnki5Tpi87T8as6A/rETmU+FTt5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR4nKODQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR4nKODQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36da8439078so3325459a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Jun 2026 19:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780884453; x=1781489253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPstpMvfPw9QP9MXsMENPNSR7V9hRvHvKGadUXgWrws=;
        b=WR4nKODQJzxfGECBBHiddb/GFJWgKfuco893KyNGNC36Ad6S83Jbd4ap4Er0I+i5h3
         QG+iCS+qdGr6xBtTai4sBA5zNPnvnnMsSk8ZYeptM2YJl3CeCXsMgKmhHHAL+yVJMYvZ
         HoSSL4TMBmosNaDWDl0v95kh+Gqi4DvHyOAJr/CfCNVzyuYqN9+rq75NAkubBvCl/nk2
         9l1AJ1yWlr5SzetdhpfgV3YTw9kSh2WiKPjirGSJ6H+yfE7tqmwFNrpyceG31vz10Ojh
         8ROH9RJXanS8WwgJwzsC9u5Piu4xRR3NQ0uGWjWaRNO+BjZBTAtg8qIwF04rZqjrNc+O
         Jang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780884453; x=1781489253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPstpMvfPw9QP9MXsMENPNSR7V9hRvHvKGadUXgWrws=;
        b=LBHvjJrbI84sPtTq4MTnNEfXQet+vqx5PoAD2KXbC3DMN1/SP5f90IValXBk1jmpQX
         khTnW1guWsttOutQcsE/AZGk0uZBEOdhJY+HbN/8/rLojCGjDHn8I9FWWayyOJAPZhjZ
         /stm+LDJzOZ8U0apo0kcXOcrfE3NJw0BP2rw+KFyglmPSClvtQrUmyWuF6pb8mq5E6/I
         VJzZOuQPGV0Ne0Vw+dozgmjMGZy+zEybMm7Tui35riGr1cG9un9fC/Ry7u5zINsK3RLI
         3vVSR2EyJV2NfOzlj9WunoObmHuJL9Xrf2QP9w4U1gK37eDrxTgaUqKDvbgITZBu/miX
         0TUQ==
X-Gm-Message-State: AOJu0YzbKAWLiDl6kdlrTobqw0Bk8mSGkyk5JKzVorTfXOyY8VYz1qcN
	nDdkzF9E6LIyTqxRgvrgArBT/SyNzcTNrX764d9nk1kj54etPnpn+SOO
X-Gm-Gg: Acq92OFlB5LqQGevDIGdLs6XMGBeRK9yHpJIOHW1U514kkIPR00VeB7zK0I1lxmhB4p
	52qqRWOgXQjR3uupbQEkx23RYNnxOS+I3CZhb7EYJ8qO4EU5Nl7aHxZWbS8MvYPfIMwPpe2/T+n
	ZbNzlHgJ3E67p8T4kb41bYav4MK5Pr4rB+J2kzWpbCd8ptu1sLNA/AoOaWDDuf2H0AlxRxEvIWJ
	vs4WLzSzJyyDWYuRPazB5BZS69/wyQj8r+150gL5RKypbEGOqT7bJS09oOpR4oQXEnxtOZfUGQQ
	5TM7vI7qdC8hyZFeBonTYoAnkSm7vDDBa6lQOAqDv3kNXd0i6Fzrqekny9tYis5W3tE0YIpCTUz
	njR22/egyy+ND2rW2/xP22bgqWhpm7H2p3sO3XdGrn6dc7cNXMO3Nb0JPJzxZlrRY8u5yy9EchS
	XpAXNbo3HgtWCwu8FYE/UqBODyP1MJKrUnnLsG081kAKouSHJ6
X-Received: by 2002:a17:90b:3d8f:b0:36d:70c8:3a3 with SMTP id 98e67ed59e1d1-370f0772dc6mr13810623a91.15.1780884453130;
        Sun, 07 Jun 2026 19:07:33 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:7098:2d38:794c:c7b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba82c6sm13550998a91.13.2026.06.07.19.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 19:07:32 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	Pengfei Li <lipengfei28@xiaomi.com>
Subject: Re: [RFC PATCH v3 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Mon,  8 Jun 2026 10:06:55 +0800
Message-Id: <20260608020655.2638028-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779769138.git.lipengfei28@xiaomi.com>
References: <cover.1779769138.git.lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Hi Steven, Masami,

Friendly ping on this v3 series. Let me know if there's anything
I should adjust or any direction concerns you'd like me to address.

Lore link:
https://lore.kernel.org/all/cover.1779769138.git.lipengfei28@xiaomi.com/

Pengfei
