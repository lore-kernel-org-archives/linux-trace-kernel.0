Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8638C2A5;
	Mon,  8 Jun 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909047; cv=none; b=bdxjT3CMeAa4MPA3fYSjUO0Wdks20x7YXrlAUx+a+PnQAcM4agkM7p+Nh1fvUUCIesnViYaKq6YgYmGb7sQIBeokHwURuJGtlZqGyZlf4Wx9caatV/ecSIx3Xs9HR70e2w3o21mW6wvqhuxvxq62Icy+JDTAQWjwWv7x6h5y0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909047; c=relaxed/simple;
	bh=WImQ7qm9myji9VI+RRwh997zTAimIL6TGWG0Ho31N70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqRh+tflZd1WH0r5ZhHJAPPKbCHTs9jT4Yd5pgkC/hFyMwUhK2xrsHNA68UkqWZ/HFClItIj2PMejNAcR1YuNtu4/AOR+zwGSWuezFfhxZyZAZQ4tLN3vX4fvk5cdpfilyIYe8beBj4M9pb0sm4gKAT867VUQZA393995xR+jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQTlFg89; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RV9KSneR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQTlFg89";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RV9KSneR"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MiPmlBMPC7HjDPG0+2TuU+DLWYsRf8A1Uqh96TGkKsk=;
	b=HQTlFg89D6YMLCD9gK1fnndhRu72oIy8pKG/19bO8rjpGCJC7coVnWPb0YH1QchfF24uhk
	j7rt/RRCePLr3Et9rhUuoZmtN47Ac/aVdf/ZHhJdV5TSGU7lHEXsGCmK5d6pgE3ghbi2Ak
	NnjiANrdo6TdTElhxD/IGaVW+o4mO4Byv3S3bkunAKunqiHBc8xQJfOkbxBB418aaFhEU8
	4CjdjWqXDc46Mcm+oX8IhuSxOPzRlNuaBgmYXVVNceeBGliTrOnKKj3D8/SwwVSzRrgMRE
	ZBx8erul8TnV3BfgsTF50E6OhNXaKcwTAqtR08U1YwxemR0eMheHO+qBUnkhUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MiPmlBMPC7HjDPG0+2TuU+DLWYsRf8A1Uqh96TGkKsk=;
	b=RV9KSneRnB9LaBiGutYa3LyVvhh8YXGAQy8lNUrGGshv3nNvwvLX28APaYzpNnqalvp036
	P9VJ2uBs4+cb/gBA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 00/13] rv: Convert rvgen to Lark
Date: Mon,  8 Jun 2026 10:56:56 +0200
Message-ID: <cover.1780908661.git.namcao@linutronix.de>
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
 tools/verification/rvgen/rvgen/dot2k.py    | 290 +++-------
 tools/verification/rvgen/rvgen/ltl2ba.py   | 202 +++----
 8 files changed, 604 insertions(+), 630 deletions(-)

--=20
2.47.3

