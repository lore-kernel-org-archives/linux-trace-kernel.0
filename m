Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1353248867
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856323; cv=none; b=J0sOWak225+MjxCYoTwMjS8KRo+dbXro58QllJh0Zek5yc4toP3PLTChZOfP9JKrgSYY2Ethgt8Lcy85L3OXIdPJ4nzFLv8KUGWkVYkUA2NcNL1BZqZOgq8ALok9Q/uQ4DZCuUpYJaF0khL1uo/uhQDmwLPbpD5ShhNXt7su6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856323; c=relaxed/simple;
	bh=y03Napea9Ec/timRtHCmgk+oNQbG3OD6OUDjlDUFauk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=csy7L/mjC5uqIINQ5rbePYauTWTJxMw7Co8ZAe6AbtlMBZkyzCKJiCPvX/CgqfUkLgyu73f2FhwtqzIcsQXvP7U9wL1MrU2c4kje2k3z8EuEVOsUjxJ5MBNL+Ir0yC3gC3mqyQHgXo3By4cw1+f4Ne6cPgYwP49mIgNda036RPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Equzpflk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Equzpflk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oMmVBDt3VvOxXCF9SVXfGcqioJOfdWUmVt6WX/Uf/l4=;
	b=EquzpflkKnFhKTHu3arNxRf2HL7D2kr/ijHibZSps0bYbFlOo5jrPkzMKg0Dt1iwPhlORD
	FgScJNI54rjKR/zd220cHNY1DkPJyO+aSD9uhlnPf8rALMrn6CNYog/mHNXDqRqvuS+j9k
	4dFUmH4L+Qsm0n3GV85bYoziYiOvVJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-UscuLpDBNpyAKzAntlegKg-1; Mon,
 19 Jan 2026 15:58:37 -0500
X-MC-Unique: UscuLpDBNpyAKzAntlegKg-1
X-Mimecast-MFC-AGG-ID: UscuLpDBNpyAKzAntlegKg_1768856316
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A9A01956048;
	Mon, 19 Jan 2026 20:58:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BC4319560AB;
	Mon, 19 Jan 2026 20:58:33 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 00/26] rv/rvgen: Robustness, modernization, and fixes
Date: Mon, 19 Jan 2026 17:45:36 -0300
Message-ID: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch series introduces a number of fixes and improvements to the
RV Generator (rvgen) tool in tools/verification. The primary goal is to
enhance the tool's robustness, maintainability, and correctness by
addressing several latent bugs, modernizing the Python codebase, and
improving its overall structure and error handling.

The changes can be broadly categorized into several areas. A number of
bugs have been fixed, including logic errors in DOT file validation, an
incorrect isinstance check, and several unbound variable errors that
could lead to runtime crashes. Exception handling is now more robust
with the introduction of a custom AutomataError class and the removal
of dangerous bare except clauses that could mask underlying issues. The
codebase has also been updated to use contemporary Python idioms such
as f-strings and context managers for file I/O.

Finally, a general cleanup pass removes dead code, adds missing abstract
method stubs to satisfy class interfaces, and introduces type
annotations to resolve pyright errors and improve static analysis.
Together, these changes make the rvgen tool more reliable, easier to
debug, and more approachable for future development and maintenance.

Wander Lairson Costa (26):
  rv/rvgen: introduce AutomataError exception class
  rv/rvgen: remove bare except clauses in generator
  rv/rvgen: replace % string formatting with f-strings
  rv/rvgen: replace __len__() calls with len()
  rv/rvgen: remove unnecessary semicolons
  rv/rvgen: use context managers for file operations
  rv/rvgen: replace __contains__() with in operator
  rv/rvgen: simplify boolean comparison
  rv/rvgen: replace inline NotImplemented with decorator
  rv/rvgen: fix typos in automata docstring and comments
  rv/rvgen: fix typo in generator module docstring
  rv/rvgen: fix PEP 8 whitespace violations
  rv/rvgen: fix DOT file validation logic error
  rv/rvgen: remove redundant initial_state removal
  rv/rvgen: use class constant for init marker
  rv/rvgen: fix unbound initial_state variable
  rv/rvgen: fix possibly unbound variable in ltl2k
  rv/rvgen: add fill_tracepoint_args_skel stub to ltl2k
  rv/rvgen: add abstract method stubs to Container class
  rv/rvgen: refactor automata.py to use iterator-based parsing
  rv/rvgen: remove unused sys import from dot2c
  rv/rvgen: remove unused __get_main_name method
  rv/rvgen: add type annotations to fix pyright errors
  rv/rvgen: make monitor arguments required in rvgen
  rv/rvgen: fix isinstance check in Variable.expand()
  rv/rvgen: extract node marker string to class constant

 tools/verification/rvgen/__main__.py        |  36 ++---
 tools/verification/rvgen/dot2c              |   1 -
 tools/verification/rvgen/rvgen/automata.py  | 155 +++++++++++++-------
 tools/verification/rvgen/rvgen/container.py |  12 ++
 tools/verification/rvgen/rvgen/dot2c.py     |  64 ++++----
 tools/verification/rvgen/rvgen/dot2k.py     |  32 ++--
 tools/verification/rvgen/rvgen/generator.py | 141 ++++++++----------
 tools/verification/rvgen/rvgen/ltl2ba.py    |  54 ++++---
 tools/verification/rvgen/rvgen/ltl2k.py     |  36 ++---
 tools/verification/rvgen/rvgen/utils.py     |  36 +++++
 10 files changed, 322 insertions(+), 245 deletions(-)
 create mode 100644 tools/verification/rvgen/rvgen/utils.py

-- 
2.52.0

