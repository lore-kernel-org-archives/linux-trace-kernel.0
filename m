Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E51386C9;
	Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154759; cv=none; b=nH4IQrmneigIgVO8Umy+z/QGW01P+lj2eu1AMO11PsKPwjSe9waM1OUD8dCk899m4GTwpx7hP0RHDHvf56ud97Gg4QFFpdvAWoY4my3AbNp1Yy7SjWyo9i5FfmnBiB+egOFCTf4JdeKZmzsKdDXfEG4BgNeh41DOVDSfoDs2WUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154759; c=relaxed/simple;
	bh=hulNd+pnlUUnyZl/m4BGBqIYtQlsI75DRGszkd55yuA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=FD2cVUmgZkTBnxdMYLeC50apxYmiyObYOByrk3ujtqmOROymbPk2laDuaJVoAPN8BbjYs4szl1usa/pfCUwjdYB3vr+abxKNKk02uGi/CwVS4if9GgrX8Be6TniusJQvDcpxIral1gItK7yfnZ7patNM0Rx6niCA/GbowawOJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJRxCmFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJRxCmFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53353C4CEFE;
	Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154759;
	bh=hulNd+pnlUUnyZl/m4BGBqIYtQlsI75DRGszkd55yuA=;
	h=Date:From:To:Cc:Subject:From;
	b=WJRxCmFnURtmRhltIstXmc25hR+i8HUALgFO3pLjQIsHPXNhbxpDxWcAFShP+qdqs
	 Aj5IpNSMrjaYetF0CorCh4YFyw3Fdr24Ml9PF/vC+MWR8tR45Rq8XjAF4ttn56wXcR
	 XOwzYIRpeeyx2ZhtuE29Wvwy4QI7sNMU9/pbcHUgrjYtWqQ/nNViKKUYRry2jofZlV
	 bB8rP6mL/hmExuH0tumeTrcu2MT0faHYhOYZz48Tzou/mgwznp3l9JauANmo35JK+I
	 mT+pibN4dZb8sKOQZqgZY8MToX05h88Z/SWX85JYDJ2Aewzk2UlimeLUxEUw80/xkB
	 2XYRmeZdx2l3w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7Qex-00000000jfj-1UmG;
	Fri, 10 Oct 2025 23:52:43 -0400
Message-ID: <20251011035141.552201166@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 10 Oct 2025 23:51:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: A couple of fixes for v6.18
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

[ Sorry for the dup, but I used the wrong script to send the other one.
  It hasn't gone through my tests to add the "for-linus" tag yet :-p ]

tracing fixes for v6.18:

- Fix tracing_mark_raw_write() to use per CPU buffer

  The fix to use the per CPU buffer to copy from user space was needed for
  both the trace_maker and trace_maker_raw file. The trace_maker file is
  used to write ASCII text into the trace buffer, but the trace_maker_raw is
  used to write binary structures directly into the ring buffer.

  The fix for reading from user space into per CPU buffers properly fixed
  the trace_marker write function, but the trace_marker_raw file wasn't
  fixed properly. The user space data was correctly written into the per CPU
  buffer, but the code that wrote into the ring buffer still used the user
  space pointer and not the per CPU buffer that had the user space data
  already written.

  There are several tests in the test suite to test the trace_marker file
  but it appears that there's no tests that test the trace_marker_raw file
  (this needs to be fixed), and this bug was missed.

- Stop the fortify string warning from writing into trace_marker_raw

  After converting the copy_from_user_nofault() into a memcpy(), another
  issue appeared. As writes to the trace_marker_raw expects binary data, the
  first entry is a 4 byte identifier. The entry structure is defined as:

  struct {
	struct trace_entry ent;
	int id;
	char dynamic_array[];
  };

  The size of this structure is reserved on the ring buffer and the pointer
  to the structure on the ring buffer is assigned to "entry". Then the data
  is copied via a memcpy() with:

  memcpy(&entry->id, buf, size);

  But the fortify string detects that the size is bigger than the size of
  the entry->id and produces a false positive warning.

  Hide the write from fortify string with:

  void *ptr = entry;
  ptr += offsetof(typeof(*entry), id);
  memcpy(ptr, buf, size);

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 649f416690a79861b646e304ccdee0465fec65b6


Steven Rostedt (2):
      tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
      tracing: Stop fortify-string from warning in tracing_mark_raw_write()

----
 kernel/trace/trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
