Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAB78697
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688812; cv=none; b=f6SrW/Kzc8MC3l7H1LPsQaisUutyLqhZ3J3BvKwTet0YE0NI3DGNmR3rCkhs3X1AdKk3GUgDD+jEU2iRA+iEvO9izlnSGFHjh+okZerMoDswq9/YowG8upO4RKTKJytv1ycp4CQy7SQQq5aCN+cUUqjAgP+cmeSqGd1mqo2s2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688812; c=relaxed/simple;
	bh=wKwKA0p4vt6AwTeHwXt7AVmIzq29IsV/+yie3gcAHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iazr0PeJyb8u89KD5IGvt8ANAXx8PJHOh9ZSd3pua3lQZOlXq4/HC7lsf3WLdSw+nyiPdGnIU2DKqbu962Gu+4GBohXMLhLx6GYZnj0RjF0tL3YQKVt9by+ajLZg4Yh3bNy3q2eF3rNpmkBJz3FPG/Lc/UBqVCpoTxIA76VJUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=lQfe4Xww; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="lQfe4Xww"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512ab55fde6so288808e87.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688808; x=1709293608; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYaGIlRWtlH5yr29hsAr3bMxvcE9aO0b9v1PXvyEfT0=;
        b=lQfe4XwwYuj3CNqRizOTSiwVbCuyYjLZeWfzSXz7VCJFGiKvqOzTd4T/3jDR+6eTAo
         rlGfO20Kq3cQzcBHZxC/ph5f47C4efBvH3mST2PLy9jmo8N2BEXfjmd2PGVDTngLuL+D
         xyPKoqnw9yGqANqrHHO6fokmDJiqQTkEt0M0BHJdm/RFeWexKsJ+mwcEkcabiTJLw1zX
         kuFpO7k83Ai4wNCYwUl3wz+1NFskHHoKGvkMj8y+aozOvcea5xGwQcIYdep84SQb8oFG
         +5gmZatuQB5znoiRDR8IXswsfg04jvsxXs7L7sQ7MkyRJ3C/y6PrJaU7FxSZ4A+YMnGW
         dyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688808; x=1709293608;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYaGIlRWtlH5yr29hsAr3bMxvcE9aO0b9v1PXvyEfT0=;
        b=UB+P/Eo1pz7zcmLCiVHSFh6UwMceJb/fBkrUJqeveV0KPzsH32xQGe6C2nz7+82ufw
         weCP90StZp7S8n65RdvlgWzfZtfOHSObtd+ifBKQ/XOVyn3sQ4ImYeto5Oxdxcd43y18
         58ReYVT2GMJS4VLTdu2DnzLiRh3w8utzsw3366I/c8/QxBwbRwnz1umEs8BCLGj8bPo7
         +rJXwf4c5DmTexNWnSBW2JABipbSHT0lbzm2eedZgEJ7pak15fE5UKmP2oeGyPnXE7aO
         C1ChiDlfTaR44KtwVfdgAEAoiS+XZ4ZaK00UZan6gEht2mT+wt9Lx36adIP/G31MBJvg
         tXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMSQ7QRhVSsiazAqoaUTMJrM00uTM4HmH2c8x0FGS/by/rt18Wh7wZ1sTieNB7F7dlSKzX/94wQMlS/6o4j1QBFpZASbBmlGBzWsdYk7ElET9E
X-Gm-Message-State: AOJu0YwkQtt0cAjSIO7xc+jHUSd3MU+dvhb2cqUOIOkzXLBMHFl26RMc
	s72WfAvc14ewfnYxOGfeML3Ob55ryeyf9A5ucoIliomb5+3ggt+LIaXvXGegJQs=
X-Google-Smtp-Source: AGHT+IH2mdJq53bkBO5sog527xIQE+kgKnqpGPuW5eYY2m4q0AZgoHvbR0Xl071UF67OKiEa7BV+SA==
X-Received: by 2002:ac2:58ce:0:b0:512:b437:4b06 with SMTP id u14-20020ac258ce000000b00512b4374b06mr1084775lfo.67.1708688807864;
        Fri, 23 Feb 2024 03:46:47 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:47 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 0/4] net: switchdev: Tracepoints
Date: Fri, 23 Feb 2024 12:44:49 +0100
Message-Id: <20240223114453.335809-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Add a basic set of tracepoints to the switchdev layer that allows us
to monitor all messages being passed between a bridge and the devices
attached to it.

Deferred operations are additionally traced at the time they are
enqueued. This is useful in situations where we want to inspect the
conditions that lead to that message being generated, by looking at a
stacktrace for example.

Start off (1-2/4) by creating stringifiers for common switchdev
objects. This will primarily be used by the tracepoints for decoding
switchdev notifications, but drivers could also make use of them to
provide richer debug/error messages.

Then (3/4) create a common function through which all replay calls
pass, to create a natural point of instrumentation, before adding the
tracepoints themselves (4/4).

v2 -> v3:

Take a more conservative approach to the refactoring of
switchdev.c. In the end, I don't know that my previous attempt really
improved the situation much.

v1 -> v2:

- Fixup kernel-doc comment for switchdev_call_replay

Tobias Waldekranz (4):
  net: switchdev: Wrap enums in mapper macros
  net: switchdev: Add helpers to display switchdev objects as strings
  net: switchdev: Relay all replay messages through a central function
  net: switchdev: Add tracepoints

 include/net/switchdev.h          | 130 ++++++++++-----
 include/trace/events/switchdev.h |  74 ++++++++
 net/bridge/br_switchdev.c        |  10 +-
 net/switchdev/Makefile           |   2 +-
 net/switchdev/switchdev-str.c    | 278 +++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c        |  87 +++++++++-
 6 files changed, 521 insertions(+), 60 deletions(-)
 create mode 100644 include/trace/events/switchdev.h
 create mode 100644 net/switchdev/switchdev-str.c

-- 
2.34.1

