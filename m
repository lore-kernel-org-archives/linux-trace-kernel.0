Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4F030C15E;
	Thu, 28 May 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956893; cv=none; b=dzL+8mTrzRIEzuamE4jsi17ZVRWNkF9hWENNUTzilPCAgkqZaXWcUajFEl22VbXcGox77sEIaGFMBYqJMadpd1HLerqoHiJ6wcxi+4OpV2EJblK04pot7zhRT0+cHHx+myVVCteP3isKNDPIy4FfmBYQTEY3ib0GuCuFincXw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956893; c=relaxed/simple;
	bh=dRNZnyX6CtyhDCm2IqTaM+bJSTvx/L8f47IuWMpxKmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCLTBYb64w/1zYGDQ3m/8LjSmDRKgJWuw+4m11oh89xje7LncftJdeaNa41S5RLKDhrE655FYcYOT1w8lqoC3cR979eR2xqkcyOl66C0X+iASpXYlbMNuc8tbnWjF6pdtZJdoko+ss6ixiPEvDAjOCUE65lHiMQoO4LPe+k1Bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pf6yCeoE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+sC2Tx8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pf6yCeoE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+sC2Tx8"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PqijoGI9a435uOkOvcEQ3KdPrr9/XtQ8oHp3AnFNJv0=;
	b=Pf6yCeoEZ6ul/SIaY7d76UUMsVeNBkXjMZybfWbvtMdBuBu8TSTlfzNGy9ma2mVktulWX7
	JQ2szrt3jQwhsIEVxo6a3Bf5WpEPjlL4VrVeTnO5SXMZbWdoaFQlMhX8jjVSUi+ysaPBRN
	BrDQzc/lpYXPDytDdLXVYgwefY6s0Uv86UNcglc4UzmEpUhjBQ0pAHlNg+PcruRdfvdp2k
	ChnyFMYoyIhnbDM9vb2NcK/lpzkvZe+JHIZ/EEdUeuzp8gFOARXpoMGq1VEnTLMxXAOkWm
	wD9cQLIofCq85AgKDnRM7MEa04qNY7zqnX7+DC1UMyOgvJIicn18YWxhfbGiMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PqijoGI9a435uOkOvcEQ3KdPrr9/XtQ8oHp3AnFNJv0=;
	b=L+sC2Tx8mqQZCL5bksNL3lsoKu+O5o3/EsJksMuJEKiXHUu+tsSZ65/PMg9O16KN9ZEozG
	Io2vVBdNDcVhvlAA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 00/13] rv: Convert rvgen to Lark
Date: Thu, 28 May 2026 10:27:48 +0200
Message-ID: <cover.1779956342.git.namcao@linutronix.de>
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
  rv: Simply hybrid automata monitors's clock variables
  verification/rvgen: Simplify the generation for clock variables
  verification/rvgen: Delete __parse_constraint()
  verification/rvgen: Switch __get_event_variables() to Lark
  verification/rvgen: Switch __create_matrix() to Lark
  verification/rvgen: Remove the old state variables
  verification/rvgen: Remove dead code

 include/rv/ha_monitor.h                    |  62 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c   |  18 +-
 kernel/trace/rv/monitors/stall/stall.c     |   2 +-
 tools/verification/rvgen/__main__.py       |   5 +-
 tools/verification/rvgen/rvgen/automata.py | 640 +++++++++++++--------
 tools/verification/rvgen/rvgen/dot2c.py    |  10 +-
 tools/verification/rvgen/rvgen/dot2k.py    | 289 +++-------
 tools/verification/rvgen/rvgen/ltl2ba.py   | 202 +++----
 8 files changed, 603 insertions(+), 625 deletions(-)

--=20
2.47.3

