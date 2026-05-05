Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88133CF02B;
	Tue,  5 May 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964388; cv=none; b=Zzk0shDg7KkBp5vm3dnMCRxdVPKUnj7FX+Jrx0YqJbZTXLCL6bA7rOVTnifDfEgoxKPZmcJ1y/c+8LHewkwZPAEtz6ciV83NHvqReateWxYtJRvVlzXH4FEvjzlIHr3F1eDgSVHkR4KaPiJvQez0h1cOYLS/FpkIzCBZeBEpuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964388; c=relaxed/simple;
	bh=MRjTT8EJWApfriFyfYc+9DXGD23nejO7MEdyZWI3FZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7FnkfHS5iTA2ZC1i28YOgQiaUEM2rktVZzEiqax+wS0kQLph7607wu78/4OSl8jeJIsN4C28RabMCXJy9xl4h/YbTgEIzKdVUOGSgOVeeLsNwdqrQgAqnwelllPFA8bbxOUtRPEAOwW/QLE2L4KxQ9HnwbJGSvqdfPjLuwzD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTvSV7AR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5AJguvk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTvSV7AR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5AJguvk"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ye1FS0V0Qn+qYomfjUY9kN3rksOuPlsCFAJsrhj0U1k=;
	b=QTvSV7AROg0HAbPuNevNc7+D4AQjUyE9sLU6ZIshitRnjMxZWD8OowqdvayLdnsmQL8lbP
	4D5THVp1BsFnj5rkwuaLdb5umawreLe6MCuXFaiKaSSXjsxkvqnconV8uArYNRknoM882t
	vOD90qtBDosl257mj91x36Bu7rRlNkh3tPEbkUxFIkfCVLW8o9MZawpXq5vuavgzXQZ2of
	wcd2JlTcSX1X0Teqq/9iNJRMqtQRrcxYOF+0hkA1nmBKCduY6qb7WaSbfrBnKdBLUdhrNt
	Xs+xgDQX4M90OPTcZ5Lq/6JmTY343SsDTiQA3HpamBvvP8T0iD6tNH0S1nKgCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ye1FS0V0Qn+qYomfjUY9kN3rksOuPlsCFAJsrhj0U1k=;
	b=W5AJguvkRpFf78EIuvoc7eQ0M/VOCN6Gf25v0AfzfDzfhSmpxCbpoBSV5b92OZXiPamcyL
	cPwfDK1eM/XZFSAw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 00/13] rv: Convert rvgen to Lark
Date: Tue,  5 May 2026 08:59:21 +0200
Message-ID: <cover.1777962130.git.namcao@linutronix.de>
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

 include/rv/ha_monitor.h                    |  60 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c   |  18 +-
 kernel/trace/rv/monitors/stall/stall.c     |   2 +-
 tools/verification/rvgen/rvgen/automata.py | 627 +++++++++++++--------
 tools/verification/rvgen/rvgen/dot2c.py    |  10 +-
 tools/verification/rvgen/rvgen/dot2k.py    | 277 +++------
 tools/verification/rvgen/rvgen/ltl2ba.py   | 189 +++----
 7 files changed, 569 insertions(+), 614 deletions(-)

--=20
2.47.3

