Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D45264614
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216587; cv=none; b=uNLFyKFSiH7q1AqLDfLK3t24We9jT/FdDrTzm0Pdc6ZOBOLUHqW9OovNP53F8/qhcqWtgHJ3fABBnrwlvAzz6+FxgaQGVr3OHSh8xJRkrI9Xmaxz7jFKME+e+jDHrbCOxjxqCNf7D4yljNsy63UqCrvLTga9Ini2i63BZVPEE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216587; c=relaxed/simple;
	bh=Yd1S6v+Q2WMJHaGvgJN0vSmiXohLdWr29uLiUrB0wwc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=F5tym/tzSw7VrlhdgnXWIIJdd8spzCBW9gPD31GWeG4RQLhSRm/RqlFhNBiw2UA8ZLuSjqVD+TKVwBAfkXdbed2730h2DTcahEsLvDWGB13xDvAxCbHByBWgrMaRFVWaJJOxWX/SIW3tbXXhC5u+KQDVVurNWcmkm/AKCVEEv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHjvmlZg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHjvmlZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cE4RlWQpK/e0hmAFx2GaTxTtycJsdUuYYQ6L1gSJQR4=;
	b=YHjvmlZgEK9cx/SBNiwX4NdTyBB5AVcdKQXw0y5+mEymq7PnFT34xR79KhlOVWIAU0MXnB
	dtMdb7S70kEr66rN9l2nakx1QG2oZQmOhdm9WdxaDzvT5vRQp6t0q4g8FmRvwN9EUSmvzg
	viVQU8vfazUXE8swnlm1cfbkislWCr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-7NRuDizzOxyvrMhzScsaPQ-1; Wed,
 04 Feb 2026 09:49:42 -0500
X-MC-Unique: 7NRuDizzOxyvrMhzScsaPQ-1
X-Mimecast-MFC-AGG-ID: 7NRuDizzOxyvrMhzScsaPQ_1770216581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ABC01956095;
	Wed,  4 Feb 2026 14:49:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1676D30001A5;
	Wed,  4 Feb 2026 14:49:38 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 00/20] rv/rvgen: Robustness, modernization, and fixes
Date: Wed,  4 Feb 2026 11:42:26 -0300
Message-ID: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: oGMowWlih0yvYibw7NvEZCJiDLIRc_VvvnbweCrXdZY_1770216581
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch series introduces fixes and improvements to the RV Generator
(rvgen) tool in tools/verification. The primary goal is to enhance the
tool's robustness, maintainability, and correctness by addressing
several latent bugs, modernizing the Python codebase, and improving its
overall structure and error handling.

The changes include fixing logic errors in DOT file validation,
resolving unbound variable errors that could lead to runtime crashes,
and improving exception handling by removing dangerous bare except
clauses. The codebase is updated to use contemporary Python idioms such
as f-strings and context managers. Additionally, type annotations are
added to resolve static analysis errors.

Changes in v2:
- Dropped patches related to the @not_implemented decorator and
  abstract method stubs (v1 patches 9, 18, 19) to address class
  hierarchy improvements in a separate series.
- Dropped trivial cleanup patches (boolean simplification, __contains__)
  as they were already fixed after rebasing from
  linux-trace/latency/for-next.
- Merged typo fix patches into a single patch.
- Changed the fix for the unbound loop variable warning in abbreviate_atoms
  pyright report.
- Reworked initial state validation to strictly enforce the presence of
  an initial state.

Wander Lairson Costa (20):
  rv/rvgen: introduce AutomataError exception class
  rv/rvgen: remove bare except clauses in generator
  rv/rvgen: replace % string formatting with f-strings
  rv/rvgen: replace __len__() calls with len()
  rv/rvgen: remove unnecessary semicolons
  rv/rvgen: use context managers for file operations
  rv/rvgen: fix typos in automata and generator docstring and comments
  rv/rvgen: fix PEP 8 whitespace violations
  rv/rvgen: fix DOT file validation logic error
  rv/rvgen: use class constant for init marker
  rv/rvgen: refactor automata.py to use iterator-based parsing
  rv/rvgen: remove unused sys import from dot2c
  rv/rvgen: remove unused __get_main_name method
  rv/rvgen: make monitor arguments required in rvgen
  rv/rvgen: fix isinstance check in Variable.expand()
  rv/rvgen: extract node marker string to class constant
  rv/rvgen: enforce presence of initial state
  rv/rvgen: fix unbound loop variable warning
  rv/rvgen: fix _fill_states() return type annotation
  rv/rvgen: add missing return type annotations

 tools/verification/rvgen/__main__.py        |  22 +--
 tools/verification/rvgen/dot2c              |   1 -
 tools/verification/rvgen/rvgen/automata.py  | 146 ++++++++++++--------
 tools/verification/rvgen/rvgen/dot2c.py     |  56 ++++----
 tools/verification/rvgen/rvgen/dot2k.py     |  32 ++---
 tools/verification/rvgen/rvgen/generator.py | 107 ++++++--------
 tools/verification/rvgen/rvgen/ltl2ba.py    |   2 +-
 tools/verification/rvgen/rvgen/ltl2k.py     |  46 +++---
 8 files changed, 216 insertions(+), 196 deletions(-)

-- 
2.52.0

