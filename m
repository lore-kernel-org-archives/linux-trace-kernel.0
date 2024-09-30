Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD118E351
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700375; cv=none; b=sa9geEQybMTYFK8aOaEpwK57Q0dGVoCX5E9OKez+VxqD+NjJqse0jQRwKDeTN7EixKA84GgLA6r/2s4LxjNGTsFaCCi1DoUzcwzTAzdIS8dJepTwoDPChGFt3P1MW1jrDVqieExIEQJV7+NpMCWyIQun25nw8vYJ9eWQiYYCfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700375; c=relaxed/simple;
	bh=DyoXCutWA6S0fNFFM+LkIdP8qA4TkorGflUMTXRa6jQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nT5x2H91Kv3iZC5EtDqKldKaHlK2XZDcAsQe2Ar4sHRQTx2ZGZCXXprgR0sJRYYvce/lxqQU3b3kk8Gb7NHsQfaVVT83EW2use2tYzokfbxepfgiM88Nxnw8SLbWs3cI1nsheS2qF9vA+HbyzdK21WieeXoXFFH1ept2fzGS6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmcWNGXK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmcWNGXK"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e21b4d7236so35696257b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727700373; x=1728305173; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyoXCutWA6S0fNFFM+LkIdP8qA4TkorGflUMTXRa6jQ=;
        b=LmcWNGXKUPLEmj5i/oO6BbKMtsTmLoFHPl9bE7iv6bjlZ9DmiUqyiFFbA9lA5uHqo+
         Bs2VXXjdcTbW7Zs2777R6DDVBzdWHuBAFA1FLq1Andhn+TjsDgDmhNY9/sIeAzUMOsDO
         mLJA63Tr2/bym2YoPsK9ULK9iz7Kz8sP6cosuZj54ogB1vwgLnoTbJLUWEzwCpfwMFMi
         oGhvwhkqZU66fvK/3dzYJyJTIHqNprTLHKkVTsQP0BzxOsePHzBEsr63nwNWjWtKYXZI
         OXr4gMn43SY3lTOqpUpQ/qvortzAciiANfY/7vgb8adx8TZ4tqaPmKws5ZxC7WuHBbX8
         /oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700373; x=1728305173;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyoXCutWA6S0fNFFM+LkIdP8qA4TkorGflUMTXRa6jQ=;
        b=paIzCT/pX3fYmLMpGRchD97twrPLDrUV5LnDCpdriRMRAsVo4C/sGNNDwqOsbTqNvz
         pFK2dmVYnsyt6Lbzsjgav4idNjHeTfT592wFwK1HSH0qC8WYhkMxlerHtMftOw3uv8IN
         kukTGX7x0wgvsQxVAuL++OLTADNNQZuMd37cVl0mAG+k0HPpC5fG4o+k7HZMhrMGhLJB
         2qb6BmjZhLMSr/l9++e7k0ThzXtbXRlWCOmzS4owoRiVfQYoodURmnphUJwMD998jEZF
         58Wqx2NwxITAX/pIexO+onTkXG8Zq7ORg3zuEnUvzjXk9gLT7+UxdkeRLgvUE3+1/me+
         h+7A==
X-Gm-Message-State: AOJu0YwJEH8F2n4VUYtn7j+tu4Nlv9fw5Xw4FQ6GB4K+w+J86uxgRElH
	ygK4isJpoI6QtaLe2UxOX6WblZ6OCD/WTjNTRdrIsUEjerC8eVN7cZ36wP7JDdczc8O0iI46Jgb
	7vs9xiwxF8vLy+wV6htfLOvSqXh+sq/jq
X-Google-Smtp-Source: AGHT+IG8CLwXMpBOD5iFeG6emSwEu6IHHX8mSIaQGjPnGcNYc3rR6khStIKRo22nBUBJYb/dHN1dmgwqerWT1NalBxM=
X-Received: by 2002:a05:690c:6187:b0:6db:e526:cf55 with SMTP id
 00721157ae682-6e2475e309amr110131727b3.43.1727700372823; Mon, 30 Sep 2024
 05:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Mon, 30 Sep 2024 18:16:01 +0530
Message-ID: <CALfBBTtqho0iEV5rpG=2uead0MPZQoRiins8yeXwY-WfZnR08Q@mail.gmail.com>
Subject: ftrace not tracing pciehp probe
To: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I enabled ftrace and set a filter on the command line as *pcie*, I
dont see some of the pciehp(eg: pciehp_probe from pciehp_core.c)
module function calls in ftrace, It does trace pciehp_isr but nothing
else.

My command line is "ftrace=function_graph ftrace_graph_filter=*pcie*
", is there any restriction on tracing static function calls?

# cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-6.11.0+
root=UUID=f563804b-1b93-4921-90e1-4114c8111e8f ro
ftrace=function_graph ftrace_graph_filter=*pcie* pciehp.pciehp_force=1
pciehp.pciehp_debug=1 pcie_ports=native quite splash
crashkernel=512M-:192M vt.handoff=7


Raghu
