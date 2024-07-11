Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043715A873;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696050; cv=none; b=aoHwxsgFF3LDJlFnq62xAr9YKW2lCoQkRvYNmQcCZjJ442rnjZ2rgm4YWnDaR4RsZBj3GX5fLAyqXlOej8+giZop5SKoXoVMxtUTDKszvPsh9pEIYndhT00+8+4Er25NW3jr8EDqy4DnV8pDrn1nGGpEOVQ324I4Egdf5mpBQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696050; c=relaxed/simple;
	bh=rE4eQli4ucBYR+6/aaL2WljIQxrbI4dTO1dgk7Ewd1o=;
	h=Message-Id:Date:From:To:Cc:Subject; b=pB1oEdrYU8sxzdtPP6tLNq1qyiQsoAFesTY59xxTI1SMjI+1+YWHwII3htyIj/HSPYapht/klsI6KzQw3GVqyLAUzh1pmSBPIRYrAhdNC/CQaBrsDbLHJPKK1jZeBoLy+gHrASDKH6oOJasAiNUDnh0CjPvN5vulYU9NYKeyZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ca87Trma; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ca87Trma"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5PhRB/yvZiYt7Y297jyfwpdQwWHVgqH9RupG4XHShE4=; b=Ca87Trmad/3SvYDJnz8fPMSX8y
	pjU+oLAUm5pEWTVB6mQGe3Zc/C2DlC04LQj7mcBnJnJ8zbrHkqNzJz9tOTdWv9/QQMFJYltzprZrb
	CFju/2q+MBoBeD84/0J4RFokRtKHAgF6NJ8r7CDBB624pOyk+gvYNMdzSQY/vJTj3G3+Shel+IXxZ
	jdWlI1wbOTjaGrJ5qx91wBjPtxgpQ66YGgZ+5yT1AE1kluNbmJ3qXhg04Dkayax9NT36SoZuTVX/a
	WPm/7Hgq7h+OvU7t7Y0eqJHALEzbS3CXPzYInlCOU7JmKyWxiLiUrWIVMXynE3LQbr/aoNfZGHP52
	ZxX7KPMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRrdz-0000000Ax6T-25Hr;
	Thu, 11 Jul 2024 11:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id ADE8630050D; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110235.098009979@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org,
 oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Hi!

These patches implement the (S)RCU based proposal to optimize uprobes.

On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func' in a
tight loop:

  perf probe -x ./uprobes test=func
  perf stat -ae probe_uprobe:test  -- sleep 1

  perf probe -x ./uprobes test=func%return
  perf stat -ae probe_uprobe:test__return -- sleep 1

PRE:

  4,038,804      probe_uprobe:test
  2,356,275      probe_uprobe:test__return

POST:

  7,216,579      probe_uprobe:test
  6,744,786      probe_uprobe:test__return

(copy-paste FTW, I didn't do new numbers because the fast paths didn't change --
 and quick test run shows similar numbers)

Patches also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/uprobes


Changes since last time:
 - better split with intermediate inc_not_zero()
 - fix UPROBE_HANDLER_REMOVE
 - restored the lost rcu_assign_pointer()
 - avoid lockdep for uretprobe_srcu
 - add missing put_uprobe() -> srcu_read_unlock() conversion
 - actually initialize return_instance::has_ref
 - a few comments
 - things I don't remember


