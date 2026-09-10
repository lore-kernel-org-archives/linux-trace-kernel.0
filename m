Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC7339388
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002619; cv=none; b=V2jXHOw4zpZbolHxxnv89OcfdDor7XExXV9A8bNsa1Ze65TjYH1mphNzpRHMtDDjxuk4RCuBwqQetqyGWw/Tffc7eGHYA/n2wgBIwoJb6Mob2ErJICM4UGTe+u4JfLvbgHLKjxxZxYKkD6MzbNvDAuf9ef4I0NDCoY3usjnKkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002619; c=relaxed/simple;
	bh=or0xzMswmj9Tj7ceDBe8I/7LXee47Ypd8r/+wEXzH2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4KnVyXYyKpsi9lYdbDy+XY+JFzlayM/oRBQRKTXz4UlB2WdG8pnmkIicTQMk/lwWSwFc1wz2PaxSKv1ZqkNYUVXjKoYKF/rZqEpAHAe/U9efO3QSxTtmWYAtfvcDNUpfiepxYXusgftFbs4lPbUw6tPshe2PkAr9cCdNyQTGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTmvnOc6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTmvnOc6"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so5421863a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789002609; x=1789607409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=or0xzMswmj9Tj7ceDBe8I/7LXee47Ypd8r/+wEXzH2Y=;
        b=FTmvnOc6cGfZDjXV4TDY7Uv0rqr/p8hHPAhoSa4cgWbuz2LR4ku/LJUWn+hjpuo/oC
         8ivazSWxugwwnmth31ELknTRH2rZnyp7XouX4D+iSoshsjCcEacNBPoTmlx0ggHiS9SV
         UHoGzPJXSyaq+/HAWyAAgd9rBOXsTuznz53c7ZrHSB6vheKweLp8yQs8igYZFeBlb2RJ
         y3SqOlb7QzUwtDrdmoaWj4KdZ6Q/MU5qP6pxjC4mIKr8Qe5tz833qq4jPGJJDn/1WAnA
         g0ZLeGdWK2JBBsBMRpL+QuSfIkwOGDe/DQobxXU71/Vok5Td3MQVFaIggJi6K6iXLM2h
         xj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789002609; x=1789607409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=or0xzMswmj9Tj7ceDBe8I/7LXee47Ypd8r/+wEXzH2Y=;
        b=JiNfjQlebaWALx3JmeCC8Qjyz3XBnHRKze/LBNXoidU+Xn6dg+OCldqbykQhRVGnbh
         kEeYV6qlWor03whVwEWGxr22Iot30EaJLGfgUgL3bG8jMc0G6qO9w9X4BUiYhW/Q3x/X
         fCOlqDESrZY5/2Fs9RMoS1xVKXe+yNxD6jxCNHEjxFDhqc4B0WBtZz6KwKEosDhxyyOi
         XgybLI6w5TetOs8jSy0wHrZWbX/4W5vH1qaErFJISgrjc0CARg1ji6Sp/AIIUPjejfTF
         DwA1hvUQWVYYAxdffLlQ2eBWW7zqeWwWEuzeM8xv6SQvsIpnhWKWuHKHg1DIYpPx6eLw
         CfNw==
X-Gm-Message-State: AFuF++nxh4a+2iKlpCO/5ihoBtwzjXlG6fLHPzE7YmkbBo5nMKPvvzZx
	KxvTTVOBoG/kJmbCI+w+CYu0k7fXMJ/WozWpOVLZaY9lePlEEV8hq6A=
X-Gm-Gg: AYBFou2qzjFAnNM4W7ZJ9EWpffvrir/ITVMdr87C5ngPxsP0b9jyd/gLV5dla6cRxLY
	usXq/prF/W2QfQyEx0EO/CioKUCJhTsV8+Q/F3oOovwa6VV70yJ7qUmqCCGEeSjXPgXLrR0n2IQ
	bWAGZgpaX4Iuw9FkbdBuDcHaG3Rwq4lryfVe5UiuZQh4v8YUi4J5wyAcntp9KrQ/Biu3H5H0myR
	lIaHlpXA+koQB+1norhUbRKT2eTLcweYKYc3zlMuKovK5ct60MjsrVjCdFp7eOHkX1cNN/Tf+aR
	jXQranKhFcAbTevqOYB23ElXPo/+jW4yfGQU/El/r4Nl+Ek1WofSguD17IJ5DVrtNgTtSWpisef
	IpmnnaYn9AGumguxMNUC0ZsqAFCWvGoLji7J0L3QBr+7IQCM/jiqF0dPJ/sV0l9WnDJn5+LJvGg
	r5yx/RZ4zDCIt0D/dMy/kEV9jDdFX36RGnMdWkVMLrI7eDVRB7WscXKr50zRjgfldbYy1Y4qBXm
	pIp9BGQ3IwHZjXWUmBA3f0anA==
X-Received: by 2002:a17:90a:2c9:b0:39b:2b5a:8dc5 with SMTP id 98e67ed59e1d1-39b2b5a9b24mr36753936a91.6.1789002609041;
        Wed, 09 Sep 2026 18:10:09 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e7f4369sm863377a91.8.2026.09.09.18.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 18:10:08 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] tracing: hist: free the var ref when its initialization fails
Date: Thu, 10 Sep 2026 10:10:03 +0900
Message-ID: <20260910011003.532262-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906133352.3815019-1-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sashiko AI reviewer reported this bug before I sent the fix, in its
review of "tracing: hist: free var refs regardless of how often they are
referenced". The patch should carry:

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-trace-kernel/20260906125025.711111F00A3A@smtp.kernel.org/

No change to the patch itself.

Thanks,
Donggeun
