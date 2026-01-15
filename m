Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD161C84BB;
	Thu, 15 Jan 2026 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444733; cv=none; b=nRMAFkaaff1f2ik/JYL4stLD/AiQEDud97MvcxGXYwpXC/G5+hEAMGPEy/axwxvFkci5O4TceS24HErupITJVybVDpqn6PKdostU4Ti1y5dKLwXXSbKYsaQuK9NgwymJxRYWgVMgOwRi2/eJlTuUDvfTbU0xL0EQr1o9Jg37gwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444733; c=relaxed/simple;
	bh=Fm/fOWK4kqRB+3S0q/lzbPNuUUk/xHotArbtbH3RSt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiIYRz4mLMAMYMkZEqBYm8K3si+WeUYZAb9ads9Ye9DzhsHI/AMONKoaGcBNuMuSwpG0ERvQ1d/ewxLE2da39Msy5Sc9L6rCKXzn1b81iFulwk2IPZK++gWm3CrBWIQyIph1j0eB1UyzYeuJwa5QDAXyR7DtTLDv5vfd+yqiyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Dt6+Fkao; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Dt6+Fkao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768444706;
	bh=BBnWa2Z2wFE2gFkP2biaefjwKinzv4/KNTEgv++fTbQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Dt6+FkaoLRuz+9Ry5srrTT3Gc7Siwyg7TEWBsJ9V/5OcUtaM12nBLLXDHzz8srsx8
	 ImpnniZriCAxbp4ursToriqXrI7GYpQbI3zMla6m0v0Z2Dr4jMYWr6xsOmGs6cOzW7
	 q/Y1ZQT7Roi+MdKv6Jhxf7ldhu0/05yh14rE5TsI=
X-QQ-mid: zesmtpip4t1768444690tb26a2176
X-QQ-Originating-IP: kipS/bV2g8WfxLsCCs1s+asHo7Re5jVFta5p9qf1GQM=
Received: from hongao-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 Jan 2026 10:38:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10802718493387944312
EX-QQ-RecipientCnt: 7
From: hongao <hongao@uniontech.com>
To: mhiramat@kernel.org
Cc: hongao@uniontech.com,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/1]
Date: Thu, 15 Jan 2026 10:38:02 +0800
Message-ID: <61F20A5F5FE516B7+20260115023804.3951960-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105135800.1f9f05ab5635e2ab85a2f2bd@kernel.org>
References: <20260105135800.1f9f05ab5635e2ab85a2f2bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NIdHI9sZK12Os+tp/ZChl2yAqYUP4MtXMm/rFXc6KDe8cGQKe/70LumQ
	+Xgjy4Xtlny86st4fV0liX1g0TL1GLhdOlhV1vMcxz+CV9hEieXDJ2yOBO2gwbdx++1MSiF
	xrjSAcupLLut4yuy1SNe/6cDvoX9pbAWHVcMclTDz2N5/TRiA4bQojoCCh+aTA87QolxO8+
	ngL+1lbUVw58rKqzy7GK9z4Vsl48XI+m+ySWhVElMDeLZOJQ8orm/QSAb150S1ekdV5Vid7
	aufii10s04B+pU/j6bXDC6bsUQVsViQQJdJoVEmX9F3DFWGIZgTqKQgUhQ0IVYFC+QZ785c
	pimh+Q7XSgvSNR0UYO+XacZPjSqW1rrFOf4yWy7O66dikQUIc3mCu46ZpdUsfXOA/l8pBt5
	/w/4zf4yvYi9pWVh/34LBQMrI7Z9C6aYJVUDxeI7OFDGtkIo2sK+863qrqE5ofUJWEzRWko
	TUgSYhjvFof6xhfyeBnfY2JM2xW2W7p0dPHkQS4dCJLkPDQLSVyi85bU1uyjg6cvzQbuxaT
	EYpFOY+oRd4yDBQiWng9RBrsgBPB8ezERaEmWgVDngV7EWG5I/dqD0LOqw2ghXFm16afqpB
	76TawtpRY+gTqHCvRK3VsG0prrDyfpcJJw13HX1UX3tcCVS9Wkd0dEP47EyoeMHwbfbgOnZ
	Xt6wCSWpPw60H33Bk7wR9SNAAaj39gs3SbUroIWceZNYCfl0aJO8rdIBURfK/EMHn2aQ3xw
	XN4skH5RZzZy7SbgrHEBbOYKQ4k9ptkNCKJPWS05fvzVjV5CXymu9UNzAonmKTIoRgj9Ndz
	9ifcEk5i6dW6YW8DjNGk4GbGV7VORCbNIiLXYzYZL95r1rTGYPzrNrZX5DkVO8UrqBDW137
	I3qpb4OUBz8m4qXvVVA+GycggjToZkod5AEO+PveimAVxV4/gckVgKAwPwxS1az9LoAOMre
	0UJP8C1tGmcHPLyTl7aeRUzbKyhbXGx7lCQmzlt7dlkafhBDFyGOJ/9C/axJwhxZuR+qXBY
	jtZXBnrzPse72DYVIW
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Hi Masami,

Thanks for the review and clarification.

As suggested, I dropped the reopt_unblocked_probes flag and simply retry
optimize_kprobe() from do_free_cleaned_kprobes() after the aggregator is
fully reverted. The stale comment in __disarm_kprobe() is also removed.
No new state is added to struct optimized_kprobe.

Changes since v2:
- reoptimize the sibling directly in do_free_cleaned_kprobes()
- no new fields in struct optimized_kprobe
- remove the obsolete TODO in __disarm_kprobe()
- Link to v2: https://lore.kernel.org/all/C5E6295166D4EDE9+20251210033321.2895692-1-hongao@uniontech.com/

Thanks,
Hongao

---

Hongao (1):
  kprobes: retry blocked optprobe in do_free_cleaned_kprobes

 kernel/kprobes.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.50.1

