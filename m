Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471748;
	b=tXdwN9nR5YzOOTHAihg4NMc49EYropwemIpc5ecVQyTudz0jBgM05993reTYSaU4heSE
	 E6epfTCVT+4N8lUhNeRCRJh8NS/y/eUrpPNgjFOXfZMYVfTqUxfgBEOKV5LSBr5llg79N
	 wHuL+SUnR74OAk6s2F4Pe9UZnV5HhkLQH4f02lO5roNzjuAO/RJFcp5XymDrMN/NTOJNH
	 QZhYBOfRnJ/cViaChC5+NgdfjDHnCuMfU8ymKlhAahTL6wXgPShbykkF6tx6nYeePSSSJ
	 dT/Kls0w15PpelaZgxPI3QZR1BAlnFYfeutxvWsfpncFBOsZtEF/ZkoTUSxKCujfKfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9swVnJsIFTaqwiyOyx92HyZhMjF20rJmhD0f7aWIjtk=;
	b=WvIxrHElOuMBneAXgY3q6ZukxHqzNbRqjllWYq4AwT48Bnk6+NlYMzl88SZfIwP4zB2V
	 wIQbY5xCmPdPab8TNkeDhN2xGHBahTP8eZe84Gld6kp02YI5RQWysSZkI87UoZgOlipsw
	 xnX/lPK/IQXjh+RopNWkFSf5lNBeWVeCA3swoOj3BYSr3p2RnxkZUCNzatMFWzR03McHI
	 OC75OCVDDyMSJlDl4nC70HTQCnPcmFxq2RVDVLa/juaieirmy05GBCx8FlU7DGtE+PGkf
	 tmuLamsxXZUgB+PObR59o5UeROMZrII4U09KsHTZizSg4U4WarwHmDkYf09SReWVTlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsd0MLVN;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64292606A31C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64292606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsd0MLVN
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so15141275e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471747; x=1794076547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9swVnJsIFTaqwiyOyx92HyZhMjF20rJmhD0f7aWIjtk=;
        b=Nsd0MLVNyEjYloLgtQyhI0rlXtLaWTrhoWJJzdeIhPVRwPXp9TwHxMyyVKfohJ0uo1
         zqzWerpdQPacrdbBun7VlOo+K8uaLEttT5vTILxlscCidV2Xir+y7yLh+O5CEFnUCo4R
         PNwLdy4NLODNJc2hbubtLbnaXAGPousxIx6rZrKlVQlHeBk/KOmyco50p5+2VJv1vrZw
         8s6jQbbrOiCJ7rz2Tgpgop9l48odC6/DQE85XW++C5SLhWqFNiOGOSZu8Tc/dBrbfsJs
         XxkvB7/zLSjyK4Sj38cqQcaA2NqNqaOVNuIjQW1DPt66IIbDo5TCbuIaz3JKmzwRJ+Df
         hpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471747; x=1794076547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9swVnJsIFTaqwiyOyx92HyZhMjF20rJmhD0f7aWIjtk=;
        b=PBfzn1FxWPmI3WHB9+OOq8zwW8qHUZfNXbLqwb+ZT1u3hC8liBQdHN3B0/7ksADM9V
         HaPFGZmz6SBufNvx/hit0TKUbp69p5A6FhnqQq6NV0/rjcsuaKm3xojUuoY+v9mjJpnW
         /ykSXdIpm1OGUfZY4vPzS5hBhy5XS7M6qEVgY1dc65y4hL0m3OPHb/Kzprl4wCSVEE3d
         FrpZqDViIqpw8IBrx0n4LDlBOBnt55yWSiYocrA952F7Cf6AckFG6ellHbQGOcZeO1Hm
         ew1Zee18XG/cPizMJoLBtzDWHh1yiwlvxY6RhMBi0idU068uqJpxTb9HZCJzu+1OaC1c
         LHyg==
X-Forwarded-Encrypted: i=1; AKwUvBzpQVJwX4XmNaKORcCkw/mk1VBIWpmHHDEihEKE8r5RhAxrasyuJ+auyQTTS2wYCyWJKqvnhmtVDQPVqGpTEeA+Dg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIizVO5w6W10BeMmQOBQGOHOrOB7KmlMb5FluT4bGbHLvt31/M
	tQq7VxKRv/SQBgDWN4pJXwlYZLnF3UfOBZD3xTCAIHPg7A/vvd9QEopHercQ+zTtQrcFbA==
X-Gm-Gg: AYBFou36Vb5BaIluD8OAN1BGJAD6y2df/z7AbkZRGuOgYWFc2GGUPq2lruZ7fuzJN68
	c/qJplwYBx7J45pKEMzEEBCAGvD/OZSTQqqBAXCPlotbpqUbTQ6WChqhPS6O6JBh2apczb520wu
	p6TxBwWTPvxalZ5D4EtG2IVLPBV8IldyT3VFfMb0S1lUBCCFvbXaPHJWcJ6yl2h5pPgYl8g59hR
	NJTQVawoIJlBPHTSUBb1xEG1DvFmYLjQoHXK+HjJ6dwHG/YwmpNIwtk68L+gxqdK3mIVwyhk3rS
	UrKvyV1bVQLLbShBkh1pleTfv7aeWn7MQN9YqqMJ9wW6SbqIaNwD9TJ82HcACK7+H1w+gEZ36lT
	IZlUYrB2hA31yjp1u4mCDz0wkOIojQpAmzK5CG+r+UWzsgq8TK0Iy9YsaxW9DFPSmzssR6EQaHW
	Co5s2Hu90VXj7l/86uN3SDS23SjiDY8gMi6S0ZArQEsOeiiP8SgaLdrdugBdIYmbIPIkpKuiLTP
	bf202PNoRxtKHkMGjArzRdQtVcbXu3O7XjE0xvAVJnQNXqffooNaanMfyg9K9Q3474f+VufwhSw
	Qu6j4ZPZ9xFHdgHhMZQWQ+SBCLk2zG4pvJCs5V/t1jQKu6KJyACqEX3rzH69JQ2/j45BdnZCrIW
	/E90sQ41CfU1fYiYrEpClejY+LdZ2GQn2iuqEWy0p5h4mb6ZXhESu5XEXpF7/hM6VacCPGQXWEQ
	2cfO9H6sG0x+JGfn0srqTICTmw9u0jJweAe5H7JQrT9DWLbov8hYHn8uk71h2zofZjlLUgde0VW
	Qzv0gD7nQ4S43R9
X-Received: by 2002:a05:600c:3547:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4ac182dbb5emr126461055e9.33.1793471746626;
        Sat, 31 Oct 2026 11:35:46 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-0247-bf06-1f38-d09d.rev.sfr.net. [2a02:8434:fda5:4201:247:bf06:1f38:d09d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm219745075e9.1.2026.10.31.11.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:35:46 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] tools/bootconfig: Fix tracing script filters and histogram dependencies
Date: Sat, 31 Oct 2026 19:35:29 +0100
Message-ID: <cover.1793471731.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Thanks for the reviews and for picking up the previous fixes. Here are
five more script fixes, based on bootconfig/core as you suggested.

They address:
- The documented ftrace.notraces setting being ignored by bconf2ftrace.sh.
- Single quotes in event actions producing invalid exported bootconfig.
- Literal filter text being mistaken for histogram variable syntax.
- Valid histogram dependency chains exceeding the exporter's retry limit.
- Helper key lookups matching unrelated bootconfig keys.

The action-quoting patch follows up on the trigger-filter fix you picked
up. It uses the same warning approach for unrepresentable values that
you suggested for event filters. The histogram scan uses POSIX sed.

I tested the conversion and export fixes in temporary tracefs instances
on my Ubuntu machine, running kernel 7.0.0-38-generic, with recording
disabled. The tests cover each relevant step and the combined series.
The helper fix has focused checks, and all 81 combined fixture checks
also pass with POSIX sed.

Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (5):
  tools/bootconfig: Read the documented ftrace.notraces key
  tools/bootconfig: Preserve quotes in exported event actions
  tools/bootconfig: Ignore filter strings when resolving histogram
    variables
  tools/bootconfig: Resolve histogram dependencies until no progress is
    made
  tools/bootconfig: Match literal keys in tracing script helpers

 tools/bootconfig/scripts/bconf2ftrace.sh |  2 +-
 tools/bootconfig/scripts/ftrace2bconf.sh | 27 ++++++++++++++++++------
 tools/bootconfig/scripts/xbc.sh          | 13 ++++++++----
 3 files changed, 31 insertions(+), 11 deletions(-)


base-commit: a52ceed51e9bf8f1ca9c2c868b14bf6861986c65
-- 
2.53.0

