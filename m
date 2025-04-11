Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38049296158;
	Fri, 11 Apr 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357094; cv=none; b=OoZQHHx+uylkIMXfzSRqxQ5gh5PNm3+GOlJ2+kKv08Lbrd/k0o8+pyHyTYX1+DEWtQAjri1Xyo41daL308W/GhXU5JeAk7/C+m7KF5RpRn4sgOHoNUw5nhvn9xcEPtvhB7hF8hf2uciQCExkwQEBfAa1eX4z50SeSaTKUbo9CNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357094; c=relaxed/simple;
	bh=VW6Z8c18bVd/gpfVGnqo3TpppdJiFkfcoQQQWsoPifw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhRwQtd7zxCCg9FMQbDVIWu/shZnBjtKtSxBDl67b7Hfod36AaOYzXv2gIVnd+PuSLLxNdmaVI2D8y2fHM041a3SjfUsClEHGp/3TTl3NCdkGej7R5g0+5lbCcEyybBzZ4OQGLM7Qdvv4iMidEwR5mzqSa609htXCBgna5eslmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MwZuHAjj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8i9K9fC/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MwZuHAjj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8i9K9fC/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJGZXygR9fN0RxtbyJu2cBH8iDRvws2BLic/tGry5AE=;
	b=MwZuHAjjpjEFiJQbYgKoR5INn1d6pOwNbOWePo7TrYyC5Dn6KoRhYa101odo5E+M/dR18Y
	KUVSg6nNiSbsLFoBmhxnmDlTdshBfhWIBw+Usn39ra7yLMqFwNJcHfuIPhFiKvSDF5Sc9h
	j4UR+Tx8S6vsN1EQOVQq2Je5/acAhSPxOn9RiU1qx5W/sfl/pVhA6E4zXLt6k+MeJYjjps
	mmA4DzSg1RsQxBpMnwPZ5WPen8fImu+XqnJgYLeEs3qjP0iVo+I0LG42O+RkClQNVtQJhb
	qmKXUSk4oQsOrPDFui+aF3yFGLA4oAkRL+Erpr4NxXzzwr6HdZT9oypXJXpG/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJGZXygR9fN0RxtbyJu2cBH8iDRvws2BLic/tGry5AE=;
	b=8i9K9fC/DjUS32QqI61ZXBj5wf+N+eXYGgP8B2NAjk1UKtLkSAG0jse3hezKwy7drNk6c9
	ytUUrgy4IdD+9ZDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 10/22] Documentation/rv: Prepare monitor synthesis document for LTL inclusion
Date: Fri, 11 Apr 2025 09:37:26 +0200
Message-Id: <e2572077addfccd2005e90c884271079d260ddca.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
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
index 0a92729c8a9b..7d848e204687 100644
--- a/Documentation/trace/rv/da_monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -1,5 +1,5 @@
-Deterministic Automata Monitor Synthesis
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Runtime verification Monitor Synthesis
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

