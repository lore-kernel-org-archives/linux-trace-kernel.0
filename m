Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BA2686AD;
	Mon, 12 May 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047081; cv=none; b=fETJleJnr4rprfy8PqRRypAFdGXlS4XIMLzygFLjq9EQayWLljSwo9utw/HIH/r+uAQXIF4Ii8hdQb6WcnPRBII/z0GiOkdfBEb5x9q5brHQMulVTBlx8hsb+m8mwRZTJxy55V3DAZCspkd1i/nYaAakufuqH+eB6PbuSswQaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047081; c=relaxed/simple;
	bh=WgE1aO9YUvOmlhuTjVRspOHWrraepbPoXdmSTVuPrz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDzzxx99l0TQXFcdNHjU6Gq6Jp8R3o/WyFNhBH6bo2/vhWkuLzZJi0X5GeRZaxIQtZDTWl+OIhDluPTpWjJbC57EEx0bQurjuUlOxSJ88x8QNNhtnx3snJkZAZ/waGOyVgEs6q4f9A7fkmsJ+prjyd2a2HnMNBFy5OCScC4WWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WlNasf46; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RIXtZlyN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WlNasf46";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RIXtZlyN"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwJdSQU9Mp7gY25s96zSaz0i/71ZPlHWpcJ0xxxuTBQ=;
	b=WlNasf46sXb651wQavPTAL1D2Zzhwp8r0GSI5Vg+0RKH2sh04pcduZTdkSc0cn+yzglRk+
	IhMWBrpQkctE7t45b2o7FMdkMjWd+iAXK/Xdu7Yy/G4w7SL3gMX4YCjnymYU3JTlD/YG88
	90RO3AuYNyvY8mwFJ7UvmgaeZW33JASKJEWTjkrHGbitss8awVBEvJXHRjMPSNZacGMQBr
	eT4fERnRq1OzCqhL8my4o04n5OGM8iFCERGd1clZb3/CrZYL577SI48D3ZA/Pt9yCUPMfN
	OSSjB7wk9NYGKoSDZu6+EA5onvTCT9nExXmMMynkyKu/77Al1FshVP2ffQA7Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwJdSQU9Mp7gY25s96zSaz0i/71ZPlHWpcJ0xxxuTBQ=;
	b=RIXtZlyNWWW+DFHuWCenrGBBTYpfpPwfO33ZYZIbMcJvblln6fo2cUHg8ImJESEgg+X98l
	zeHkEzNq2a16+mCA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v8 10/22] Documentation/rv: Prepare monitor synthesis document for LTL inclusion
Date: Mon, 12 May 2025 12:50:53 +0200
Message-Id: <2ab7d3a2122b5d8e640d25abad1ef95aded8cac2.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Monitor synthesis from deterministic automaton and linear temporal logic
have a lot in common. Therefore a single document should describe both.

Change da_monitor_synthesis.rst to monitor_synthesis.rst. LTL monitor
synthesis will be added to this file by a follow-up commit.

This makes the diff far easier to read. If renaming and adding LTL info is
done in a single commit, git wouldn't recognize it as a rename, but a file
removal and a file addition.

While at it, correct the old dot2k commands to the new rvgen commands.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/index.rst              |  2 +-
 ...or_synthesis.rst =3D> monitor_synthesis.rst} | 20 +++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)
 rename Documentation/trace/rv/{da_monitor_synthesis.rst =3D> monitor_synth=
esis.rst} (92%)

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/inde=
x.rst
index e80e0057feb4..8e411b76ec82 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -8,7 +8,7 @@ Runtime Verification
=20
    runtime-verification.rst
    deterministic_automata.rst
-   da_monitor_synthesis.rst
+   monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
    monitor_wwnr.rst
diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst b/Documentatio=
n/trace/rv/monitor_synthesis.rst
similarity index 92%
rename from Documentation/trace/rv/da_monitor_synthesis.rst
rename to Documentation/trace/rv/monitor_synthesis.rst
index 0a92729c8a9b..85624062073b 100644
--- a/Documentation/trace/rv/da_monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -1,5 +1,5 @@
-Deterministic Automata Monitor Synthesis
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Runtime Verification Monitor Synthesis
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The starting point for the application of runtime verification (RV) techni=
ques
 is the *specification* or *modeling* of the desired (or undesired) behavior
@@ -36,24 +36,24 @@ below::
                                   |  +----> panic ?
                                   +-------> <user-specified>
=20
-DA monitor synthesis
+RV monitor synthesis
 --------------------
=20
 The synthesis of automata-based models into the Linux *RV monitor* abstrac=
tion
-is automated by the dot2k tool and the rv/da_monitor.h header file that
+is automated by the rvgen tool and the rv/da_monitor.h header file that
 contains a set of macros that automatically generate the monitor's code.
=20
-dot2k
+rvgen
 -----
=20
-The dot2k utility leverages dot2c by converting an automaton model in
+The rvgen utility leverages dot2c by converting an automaton model in
 the DOT format into the C representation [1] and creating the skeleton of
 a kernel monitor in C.
=20
 For example, it is possible to transform the wip.dot model present in
 [1] into a per-cpu monitor with the following command::
=20
-  $ dot2k -d wip.dot -t per_cpu
+  $ rvgen monitor -c da -s wip.dot -t per_cpu
=20
 This will create a directory named wip/ with the following files:
=20
@@ -87,7 +87,7 @@ the second for monitors with per-cpu instances, and the t=
hird with per-task
 instances.
=20
 In all cases, the 'name' argument is a string that identifies the monitor,=
 and
-the 'type' argument is the data type used by dot2k on the representation of
+the 'type' argument is the data type used by rvgen on the representation of
 the model in C.
=20
 For example, the wip model with two states and three events can be
@@ -134,7 +134,7 @@ Final remarks
 -------------
=20
 With the monitor synthesis in place using the rv/da_monitor.h and
-dot2k, the developer's work should be limited to the instrumentation
+rvgen, the developer's work should be limited to the instrumentation
 of the system, increasing the confidence in the overall approach.
=20
 [1] For details about deterministic automata format and the translation
@@ -142,6 +142,6 @@ from one representation to another, see::
=20
   Documentation/trace/rv/deterministic_automata.rst
=20
-[2] dot2k appends the monitor's name suffix to the events enums to
+[2] rvgen appends the monitor's name suffix to the events enums to
 avoid conflicting variables when exporting the global vmlinux.h
 use by BPF programs.
--=20
2.39.5

