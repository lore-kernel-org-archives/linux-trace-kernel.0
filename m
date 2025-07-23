Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED926F469;
	Wed, 23 Jul 2025 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253079; cv=none; b=F84PqrcGy1fKu68LhUAxAvzykdr7ZMRgnf6hPAx074OU4WAo0qy8SmuwZzmouwnnLhwJ+w/HthQD7LxTZ7GLMfZG1KZTSQqu9bRWzuKNFTmmoU58oE17qc2cWqZNEYA03AX8e7KKlwKih39oRM8o3oppBB3prV8PeESYdYEjwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253079; c=relaxed/simple;
	bh=k9R4yjGMDobmIkwUzJUXfxSEQtp9X7DWl21wxHwt3M4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpUDSohoxFbXoEPJfFrn5nRQxgC8ViC64mL4+FUzt1qzOMadHAOx49zYmISgQSkezZ4cD7q/8RYsw+2zT3G4ekvtrxqzXUM9zX2MEUjlWrRYf37nsCXX2c8nQ4ZeWw8K6BKGqL1B5us94eDRJeuwBI4HbtRgmaT+KacffpY3cIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqSZ43u9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=660tltRq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqSZ43u9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="660tltRq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753253069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3V0/rGwlR55HAl8JOs3UEmwmVZnmCeadoaAdntkCUog=;
	b=LqSZ43u9V1QGUDOsV3xGugKt/q8D5RoSKNJqzq5aAHIap0lPMzNTRmi1Zf5zhOTMN0I7Kd
	3sPRiVHl0lBTQjyYycCTE5XAn26HnKEb+EzAS8qrVo5wez5JfSTwWgKX5ctI5vRmfG2qPS
	07/Mr1a4h4dxtzDe1a4TTRwVGVlZ3ryE/KdRbZQjmzxRvmxy9yRXhDNNm/rA6COtmV64D4
	jPO2QZ/BMx6iufZnYkW7I4cZPBxJcqOMKSd4l/sFDHDmMEX6ncbi5EFQ4wY0Lp+7INa69D
	Z0BePORCKu9rKb1/6ry3xUxpRLU2+1gCQNOWD9aflGEZZQKhwK6Ojw05wGdw+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753253069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3V0/rGwlR55HAl8JOs3UEmwmVZnmCeadoaAdntkCUog=;
	b=660tltRq4fX2XhBdodpjyPR0OITaprFUfyxk93AOl0IdzhvepK8JQznyyfp/Z0zk1OUpbg
	Rppy5ZDIunfV4BDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/5] rv: Clean up & simplify
Date: Wed, 23 Jul 2025 08:44:18 +0200
Message-Id: <cover.1753252872.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series removes some redundant code and simply RV.

Changes in v2:
  - drop the "nop" reactor removal patch
  - clarify commit description of reference counter removal patch

Nam Cao (5):
  rv: Remove unused field in struct rv_monitor_def
  rv: Merge struct rv_monitor_def into struct rv_monitor
  rv: Merge struct rv_reactor_def into struct rv_reactor
  rv: Remove rv_reactor's reference counter
  rv: Remove struct rv_monitor::reacting

 include/linux/rv.h            |   8 ++
 kernel/trace/rv/rv.c          | 210 +++++++++++++++-------------------
 kernel/trace/rv/rv.h          |  39 +------
 kernel/trace/rv/rv_reactors.c | 132 +++++++--------------
 4 files changed, 149 insertions(+), 240 deletions(-)

--=20
2.39.5

