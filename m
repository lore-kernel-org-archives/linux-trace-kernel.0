Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA53254AE;
	Wed, 15 Apr 2026 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250285; cv=none; b=uUxpY1bcavGa13dCuM9KV6sOFn6TNNhFr2kiWXaiZR3whlLrJhnUuudZ/k46FABb0HHfCGHB/R3h+pgEhJO7G328f+SfALlbqBHqL/ucCeJ9dEEW4WW/NdK4neP2O+t/m6tTuaaBZEoY0+ElQZczzUhmCWRyVrdcvfGGE96UfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250285; c=relaxed/simple;
	bh=CyU74KXJoPVy9wHhzaaCz/ocAzvNPsFB8F9Y5DxkgUo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fqlnA24QH48EVNKdfOBiNLsQdgEgx5IS5y8VS0UyRr6nCVtQ/al91CIdpyhwLpoj7g5gMYsK/fjVxjfsDcMntTaZlOTuVzJ8QFb3i518oYD7JOdBeFvKJpyX1LrN5qNH+5HBx5MRNuMH0WK/r0rKDLD2TVqsey1f3ZWxfVZZB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=grNVi3Zw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="grNVi3Zw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=vh9FM8OdczURJnYgSMA2Jda5I3uk3ZYXssjNmN3rIR0=; b=grNVi3ZwgllC2oiuO4vyPjU0dk
	tyGpF6575DAAqszkTcDcgyzkZ/NEsEbv/wCmO/BpH/VvRRLRxDkmQbdW08nE3dniBh2Hm6cWZ1P9K
	yMpPtcb+eJZBk8jedaoJ46FpFJAyugUjLcR3ePn+zurD0Samx2pYwitU7JtP4RoKpBauVaFks/S8b
	AN5sRHIsdBacu28CL6xHqIKDDKwZH95ANN/IO7tr3Cb+CSlCTcW6irYpwsItgk5aNluKTw5x/zLc5
	oNZqjHBC6XlXGn88sjlJBrkk+wgE0x4S5v71Xh14Deqc4rGl3UnwtTyBGicwYj51Ap+KGZG6Xa0on
	PCvMs87A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCxq1-00DmiH-0a;
	Wed, 15 Apr 2026 10:51:17 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/3] bootconfig: break dependency from memblock
Date: Wed, 15 Apr 2026 03:51:09 -0700
Message-Id: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1t32kC/yXMSwrCMBQF0K087riBprR+shURSeJtfSKJJFUKp
 XsXdXgmZ0VlUVY4WVH41qo5wYltBPHm00SjVzhB13a7tre9CTnPMadRpwt9eSiLOdIehsiwt55
 oBM/CUZdfejr/XV/hzjh/J2zbBxl2C5N2AAAA
X-Change-ID: 20260414-bootconfig_earlier-9e185ceb71ae
To: Andrew Morton <akpm@linux-foundation.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: oss@malat.biz, paulmck@kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=leitao@debian.org;
 h=from:subject:message-id; bh=CyU74KXJoPVy9wHhzaaCz/ocAzvNPsFB8F9Y5DxkgUo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp322h34xhjNldpM4y/J07wtv1NXskunAY7feH3
 NpDOZK7NjyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCad9toQAKCRA1o5Of/Hh3
 bVmHD/wLGGz0Gt86J2uGTZL88r0+dT7xaR49B+WUyVtkPW9wSKagHLm6KC1n+sdpzRWvBYk6XUF
 4OHmouisaNCeUOP8udCjMnYy51NI4K/Xk0YyaXoUTfcEqilbJJiJSlfGoan2m4EKGbWKj3HSuWj
 XKmkQ7+RrYfqxs3l+diURW65rX2uqQ1aDYxyVH2D4SccqQsFHmuSgBhSpf1m5AvPdsLZUnnDqtc
 Eo8R0QyYIrhDZGX2d9nubeyVlZn7BcI3MfJFdodhZSwtunfVejbiuohp3Uuhz121kwvK+RZCH5e
 W/S1UCv68265/6HEVpEhK4jj0vk5XUAds8W7nTlyFAcXsUL+RYZf0mT9RdL7WRMNeBG8e2g+YQH
 YkuT6/r/eZ+x8DEo5uUsSbtpLbNzQluYGxL9HJHHfH7L1cMoy9nJd2HWQsE+IFqvGXpycP14Wei
 NMzUKitJNkxQfUKm78ihlKJ2hsCdpjLqD0RnTcsrfXGi0RSFDBHJBNEfLmaHiaivFHmRnLotcdY
 JRqlQjVeWCAPn/Uf4w3FrX9EmV7qA2vhLpX+DzHRU7cAN+QYVz+Gd3L8NxaQlVY4VOw/vFlf6jx
 TwaVJfhN3WyL/Vm+2RH15N0DGJkS1xCSYsi7W8rfikBmvq0KjwHGPCSzcIjBYWRCs7DkOCM7NFI
 LbwZs6Vm01PVV2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series moves embedded bootconfig (CONFIG_BOOT_CONFIG_EMBED) parsing
before setup_arch() in start_kernel(). The goal is to prepare for a
follow-up change that will allow bootconfig to provide early_param()
parameters (e.g. memblock=debug, loglevel) that are consumed during
architecture-specific setup.

Currently, bootconfig depends on memblock for memory allocation, which
is not available until setup_arch() initializes it. This series removes
that dependency by replacing memblock allocations with static __initdata
buffers (~96KB total, freed after init), then splits the bootconfig
loading into an early embedded path and a late initrd path.

The static buffers are used by both the kernel and the userspace
tools/bootconfig parser, which simplifies the code by removing the

These patches alone do not change user-visible behavior. Bootconfig
parameters are still stored in extra_command_line, which gets merged
into boot_command_line by setup_command_line() after setup_arch().

Making parse_early_param() see bootconfig values during setup_arch()
is a separate change that will follow once this infrastructure is
accepted.

Keeping the two efforts separate simplifies review, since the
early_param() integration is a non-trivial change on its own.

Some discussion that led to this decision:

1) It is not trivial to parse early param after setup_arch()
https://lore.kernel.org/all/20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org/

2) An similar proposal from Petr 3 years ago:
https://lore.kernel.org/all/20231121231342.193646-2-oss@malat.biz/

---
Breno Leitao (3):
      bootconfig: use static buffers instead of memblock allocation
      init: use static buffers for bootconfig extra command line
      init: move embedded bootconfig parsing before setup_arch()

 init/main.c      | 91 +++++++++++++++++++++++++++++++++++++++++---------------
 lib/bootconfig.c | 56 +++++++---------------------------
 2 files changed, 77 insertions(+), 70 deletions(-)
---
base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
change-id: 20260414-bootconfig_earlier-9e185ceb71ae

Best regards,
--  
Breno Leitao <leitao@debian.org>

