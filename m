Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940776025;
	Sun, 27 Jul 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637484; cv=none; b=uWYURVPiSISYRmeOSVBajoHWihxKmZ0//DPiHu2PkquFU0thUaGSUb8yh5ybC9/pyEzA6l06bOEqau58Iea0HtBquiKccH+qZFo+9Xx0cmvIDIUjYUlFOH/gZFffHLduDFRrkup68upT1twvxDXburiEjaCh5UoqecT3zkTCv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637484; c=relaxed/simple;
	bh=42nZDnNo3Kj3QwPYSIVM08EwdEkERI5If71kLH8lFiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qQnVb9MeNE2PrYLtJNQgcEg62PWy2A+sfmIAyHhbz0AnAWF8hFz+xRGAvTKxhap/sVcO03/RxvJPBkkifV4PA3BuFuCzUDkJWyHtEyzvVdQh+9IJpjwSeNp6nfg/7pqE1KVznjp0F5ITFKDTeEiVhS5jSWuL2xo+ZjCdBG3UK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CUU99cad; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAHvaomb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUU99cad";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAHvaomb"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753637481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kO5zmb0PthmkW6Rxt3RFjdQIojJ5eWglkTCic4cRXgo=;
	b=CUU99cadXzkYsDL4UrlAlr9qbsL0gbVdS2to0AbNO5dfHsgd0xedP+e54aD2JlIAgBKoF6
	Sk/NB6H9+L3UqHXCTgH8qwUv1qgIXr+J0mF9krjthdoHZtFKF0/E3YxVNyRcZaFHU1sZ+m
	afjYH9GlttdNDiO0CF9SJKiMLglAcLsuUAnRp0f85Z/MKfxyXLstiRHY5CJeXTB//XCg6z
	v90ji2IJOBfM7jUesfFgwE/d5/hCK0QhazxDHtv6WwH0HmjXeCimJ/5NFtT41DCbZ8+wsV
	YDh6E6g+Q7273plCcFf1AyKrQV6LEJjvttuLCLucjfUZh/hRtH8TZZ9bZfC3IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753637481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kO5zmb0PthmkW6Rxt3RFjdQIojJ5eWglkTCic4cRXgo=;
	b=TAHvaombUuIP0UtHDsZHMUD+MTHBLbpVmkkrQOJvmOnQM0fkmiIRJZoXcuYLZM+B2wGXg5
	YX8GqIVSnSyPHGAA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] rv: Fix wrong type cast
Date: Sun, 27 Jul 2025 19:31:11 +0200
Message-Id: <cover.1753625621.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After my previous rv simplification series:
https://lore.kernel.org/linux-trace-kernel/cover.1753378331.git.namcao@linu=
tronix.de/T/#t

Some RV's available/enabled reactors/monitors files do not work anymore:

    root@yellow:~# cat /sys/kernel/tracing/rv/available_monitors
    nop: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD`=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDZ=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDu=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD-s=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
    nop:=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD@>H=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD

    nop:
    =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
    =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD8=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD:=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
    `=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD

    root@yellow:~# cat /sys/kernel/tracing/rv/available_reactors
    =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD8=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
    P=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDx=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
    8=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
^=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD81s=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDI?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
8=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD

It turned out that there has been a type cast mistake in RV all this time,
but it still happened to work. Due to the recent refactor, the mistaken
type cast got "promoted" and became a real problem.

This series fixes up this type cast.

Nam Cao (2):
  rv: Fix wrong type cast in monitors_show()
  rv: Fix wrong type cast in reactors_show() and monitor_reactor_show()

 kernel/trace/rv/rv.c          | 2 +-
 kernel/trace/rv/rv_reactors.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.39.5

