Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082F3438A4;
	Fri, 19 Jun 2026 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848354; cv=none; b=ZfOBe8MQMlf5rc3qiM8Vs8kKLQizO9Qo3+yvaFekSApmxcnWQfInIcqu6rnPgzO5GS9WmVcQqcrU/D0/r1JFBHCLr698Kt3xpAWT/7m6qYzDVIb6zM0g5R+Bcylv+S2uodXswMZPd1j8s8clZR5m/T2n3h/DMfzZcnJL4VB1vrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848354; c=relaxed/simple;
	bh=Eg8t41pMOWWrduPXWNrzBc8G3rKPOll3N2vde21MGsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQdbnyrLTlswyJzgyAFlCWI1+NtE/4DqW9phSueyX1MYXzBqe4/hqE3N2IaE5axofPbCT06Ed1kMUmGyvl9dGsTs/oglvHpvvXRTJubIq/85leGacBu9mPr07hYC9amXJdOu3Beh9dWYE8K4eAUjYZzgI+eTPoWE6AayIcXZ2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbHUtiQ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=50RGuS+i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbHUtiQ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="50RGuS+i"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RrSiBzQbDLLZOpucVMD4WSq1slvu306/40/sKFtrblA=;
	b=CbHUtiQ3nTtrZly3zqhIBQFICzpsnLHwmyDmJ5BUdWJsJjfBBdRKS3UVyfjcbfsK3NDFCs
	E30R95ujIlFupeQKv7e/Z0FLTOmlv4DgdgH3vJGeE8OTK1WACP0hcGddfdWPWlW80B+v1z
	og3JEmHn+eM/nG/tFDCyGUK3Yi5ieTY2Vo1CUb+/6myVRrILCERJtuTLQDeNFrQXSAEqSw
	hGMQhodNr7s/C9/3DE1otog4lD/xFfIE2H942chJoX5IX+jii71aPqeQvUiWtUTCb4zbca
	yvSby4+3HI8oD5RWZBoNtMaPlAsPlgmA1vX/1HmlS8smcEzPDppCjVYu+Bc26w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RrSiBzQbDLLZOpucVMD4WSq1slvu306/40/sKFtrblA=;
	b=50RGuS+iG/AtEt9OchAXXB16tqt9hvHOSdYPlMbLwxYIq1HYPT2gLMqeDksQolqmBBya4n
	oLWIaayAM6wH9lDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 00/13] rv: Convert rvgen to Lark
Date: Fri, 19 Jun 2026 07:52:03 +0200
Message-ID: <cover.1781847583.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series converts the linear temporal logic parser and the automata
parser into using Lark.

The LTL parser has been using ply - a parsing library. However, ply
was recently announced to be abandoned. Furthermore, ply does not
offer the features that lark has.

On the other hand, the automata parser is mostly raw text processing
which is quite fragile. For instance, by slightly deform wwnr.dot (but
does not make it an invalid dot file):

digraph state_automaton {
	{node [shape =3D plaintext, style=3Dinvis, label=3D""] "__init_not_running=
"};
	{node [shape =3D ellipse]
	      "not_running"};
	{node [shape=3Dplaintext] "not_running"};
	{node [shape =3D plaintext] "running"};
	"__init_not_running"
		-> "not_running";
	"not_running" [label =3D "not_running", color =3D green3];
	"not_running" ->
		      "not_running" [ label =3D "wakeup" ];
	"not_running" -> "running" [ label =3D "switch_in" ];
	"running" [label =3D "running"];
	"running" -> "not_running" [ label =3D "switch_out" ];
}

the parser would be broken. Furthermore, the code is a bit hard to
follow with raw text being stored in lots of variables and sometimes
it is hard to figure out what sort of text is stored in the variables
while reading the code.

This motivates me to convert the automata parser as well. The plan is:

  - Introduce Lark and prepare the parsed states, transitions and
    constraints

  - Convert the parser piece by piece to the parsed results from Lark

  - Delete the old code

I struggled with converting __find_inv_conflicts(). So I decided to
remove the dual clock representation in the HA monitors, which allows
me to delete __find_inv_conflicts() entirely. This makes the code
simpler overall.

After the series, the generated HA monitors are mostly unchanged,
except:

  - Clock representation conversion is gone and
    ha_check_invariant_[ns|jiffy]() takes a new argument

  - The ordering in ha_verify_guards() is changed, but still
    equivalent. This is because it is now sorted lexically.

The generated LTL monitors are sadly significantly different, but proved to
be equivalent with runtime testing. Further work will make LTL monitor
generation more consistent.

v4..v3: https://lore.kernel.org/linux-trace-kernel/cover.1780908661.git.nam=
cao@linutronix.de/
  - fix missing operator "!=3D" and unit "j" in the grammar
  - fix generation error when time values have units

v3..v2: https://lore.kernel.org/lkml/cover.1779956342.git.namcao@linutronix=
.de/
  - remove some redundant imports
  - fix build failure due to passing wrong parameters to ha_invariant_passe=
d_jiffy()

v2..v1: https://lore.kernel.org/lkml/cover.1777962130.git.namcao@linutronix=
.de/
  - address human's reviews and sashiko's reviews
  - handle lark's exception, yielding a much better error message

Nam Cao (13):
  verification/rvgen: Switch LTL parser to Lark
  verification/rvgen: Introduce a parse tree for automata using Lark
  verification/rvgen: Implement state and transition parser based on
    Lark
  verification/rvgen: Convert __fill_verify_invariants_func() to Lark
  verification/rvgen: Convert __fill_setup_invariants_func() to Lark
  verification/rvgen: Convert __fill_verify_guards_func() to Lark
  rv: Simplify hybrid automata monitors's clock variables
  verification/rvgen: Simplify the generation for clock variables
  verification/rvgen: Delete __parse_constraint()
  verification/rvgen: Switch __get_event_variables() to Lark
  verification/rvgen: Switch __create_matrix() to Lark
  verification/rvgen: Remove the old state variables
  verification/rvgen: Remove dead code

 include/rv/ha_monitor.h                    |  64 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c   |  18 +-
 kernel/trace/rv/monitors/stall/stall.c     |   2 +-
 tools/verification/rvgen/__main__.py       |   5 +-
 tools/verification/rvgen/rvgen/automata.py | 643 +++++++++++++--------
 tools/verification/rvgen/rvgen/dot2c.py    |  10 +-
 tools/verification/rvgen/rvgen/dot2k.py    | 294 +++-------
 tools/verification/rvgen/rvgen/ltl2ba.py   | 202 +++----
 8 files changed, 608 insertions(+), 630 deletions(-)

--=20
2.47.3

