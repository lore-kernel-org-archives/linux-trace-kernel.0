Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32792DEA61;
	Sun, 10 May 2026 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437295; cv=none; b=rfeBvrqWAXnaevTVTfznA6GZlzI74H7CAX26uYMS6w3Y/lpwWO4EftxfnctoL8Kvt03WD/vJXZEpV4YtUpdcEWSTTJ9cJ0ulk+AX5nEJUGInbMK810DroHnQV5J+dd0wkDZ/BuCpkLG6x6BAtetHmu0HVQtZ81h6hG3NAhN3H/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437295; c=relaxed/simple;
	bh=S74AI3g+IW8PNKKi5yUmiRKl7EkeWgwF4COLmbMFcks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MXyMmwN3H97AJZKRN9cnTpCL9TE03HlD8bij8PBIIM4Jebv2zOR8scq0/24yNn6hUs93xFD7tse7Wjw0qNKIpGFpDFDyo7CSDYQUX0n+zgceR7mEHQ6TxfUCWuVcvUCIJNvwwWVaybymuCgVBZfpeDQlWMre9T1a9GLyUDqy/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1EwNvb+r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PwxXbGi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EwNvb+r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PwxXbGi"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778437292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKBiZ3zeidxeN840PSjA8QAer9/OtGTG89bv1TQY0M0=;
	b=1EwNvb+rd8DFqn0AtOaeVKc/UKBEEdLAhRQf0+RVlgsgmtVXXeiAnB9iTY++ISw2Ki140r
	QE/6+2qpzIOyGM1+5293hDwAJhi86AEPYd06CKVLcNI2+Uj2RXELJ/x8ARDVK1LBVqTW4E
	Gm9bZLaAokH85vUlXzmJHSTD4rd1tOrAxfjKzkHMCPZS3ql2+HFkgAA7rWdbLTFsjoyXZ7
	fSR/9McANS6A84WT+2W7nbhyYvcDwp57nPI3lTJZjLL6/L39WNyJ6N1xqfhSeye62pveHP
	03h0CfIL2kefmYoueA2aRRciNrj+z1oBc983qASxzPpfEfYQacxzGzb6hJtefQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778437292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKBiZ3zeidxeN840PSjA8QAer9/OtGTG89bv1TQY0M0=;
	b=2PwxXbGiRbNz6ty5zATXaCmcLluNyVMdqqjCrAquxZMJ+I6dBm1BLcKE6vl4R4BlktfiX2
	ADEGdo2WngR4HhAw==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] verification/rvgen: Implement state and
 transition parser based on Lark
In-Reply-To: <dba16e4fe794c5aa237f3360fef5fc22ae32c60b.camel@redhat.com>
References: <cover.1777962130.git.namcao@linutronix.de>
 <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
 <dba16e4fe794c5aa237f3360fef5fc22ae32c60b.camel@redhat.com>
Date: Sun, 10 May 2026 20:21:32 +0200
Message-ID: <87wlxb2kib.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Monaco <gmonaco@redhat.com> writes:
> Looks good, although I need to put more effort to understand the grammar.
> There's an issue parsing events though:
>
>> +class EventLabelParser:
>> +=C2=A0=C2=A0=C2=A0 grammar =3D r'''
>> +=C2=A0=C2=A0=C2=A0 events: event ("\\n" event)*
>> +
>> +=C2=A0=C2=A0=C2=A0 event: name (";" guard)*
>> +
>> +=C2=A0=C2=A0=C2=A0 guard: reset
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | rule
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | rule reset
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | reset rule
>
> I'm not sure if it could be solved better changing the grammar, but this =
doesn't
> work in case we have both a reset and a rule, e.g.:
>
>   "event2;env1 =3D=3D 0;reset(clk)"
>
> It apparently saves only one of them, the other would end up in args[2].

Thanks for pointing that out. The grammar is broken, it allows any
number of guards and does not require a ";" between reset and rule.

This grammar change fixes it:

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index cc42b8127fc0..d8c5e9028364 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -275,12 +275,12 @@ class EventLabelParser:
     grammar =3D r'''
     events: event ("\\n" event)*
=20
-    event: name (";" guard)*
+    event: name (";" guard)?
=20
     guard: reset
          | rule
-         | rule reset
-         | reset rule
+         | rule ";" reset
+         | reset ";" rule
=20
     name: CNAME
=20
@@ -312,6 +312,7 @@ class EventLabelParser:
             return ConstraintCondition(*args)
=20
         def event(self, args):
+            assert(len(args) <=3D 2)
             name =3D args[0]
             rule, reset =3D None, None
             if len(args) =3D=3D 2:
