Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45F38B7A5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090537; cv=none; b=W/OekT81zb4oCFBxA0BCQtb+H9RfQxVNT/+0eHOY/zQ15A9exmQeDLUX6eimcHy2pRfwJyeDes+HDGZ1/YGdG1XqQlysso72wkVyV74kr89+Co7VP1uZtZAxGPTt9vkPjozd1QN6e0MZZR6cqol7T0loY6dna7R83mkKtV2OtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090537; c=relaxed/simple;
	bh=3+o2/VO5R0mB+68o7NKmUJbTFlIi1AwDevpwEFP7E9A=;
	h=To:Date:Mime-Version:In-Reply-To:Cc:Message-Id:References:
	 Content-Type:From:Subject; b=lOKGDBU89MQIqMMopIz78eOwpZ6Gli5NQodeQf0+1iG8sVT1YsfUeVpjKlC4X9/WEmM6zdFWVoS2jR5CrBsKlMh7ONv0oqgomukni/q1JpwiCWCpC1woQl+S/zeji/buVuA4x9iEy32MwljtdmOBwMgoS5qLcoFmSt5twWFnBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xoeu3nT1; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xoeu3nT1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786090529; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DbvObTx+d2D9PFgjN7VFX42tnaAlyiskU4HY5Chv8tA=;
 b=Xoeu3nT19ies+apLFad9bl4ppsl42T4Pp0uAohgdGvLTNmIqzFTG+aOe3NA9b1b60jhQAJ
 7qC1RnekwYMKKuLkJ+oqbGJ6lfzuoZASc+/3pMnOn8TbaDwnY6W0XCIRoGWmStRzueZMH1
 XYY8eHTx2NDIQgYW80Q92s/BipjejGZLi/vApLsdPcKXdeF227S4XoDfKxeJ/Pb9h2lVRo
 LWRfJKl4VFaBCvUlZTYfHY84toUg3gDFHPNhsLsl1CO9ylKQUn1sVJWGuxwIMKZ/v8NxVQ
 xaxzCu4yPh0LG2KIpORqvcXHnXdc05njiyfS9S1TYyZW9PvDj2RkUFnqSQRlbw==
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a75941f+1cbac0+vger.kernel.org+qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
To: "Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>
Date: Fri,  7 Aug 2026 16:15:10 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260806083101.2651025-1-qirui.001@bytedance.com>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Shuah Khan" <shuah@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, 
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, 
	<linux-kselftest@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260807081512.2974757-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20260806083101.2651025-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH v2 0/2] selftests/ftrace: Fix add_remove_uprobe robustness

Hi,

This series fixes two ways add_remove_uprobe can construct an invalid
uprobe offset.

Patch 1 follows Masami's feedback on v1 and forces the C locale in the
top-level ftracetest runner, rather than setting LC_ALL=C around each
readelf invocation.

Patch 2 fixes the remaining offset issue. readelf reports the ELF entry
point as a virtual address, while uprobe_events expects a file offset.
Convert the entry point through the LOAD program headers so the test also
works for non-PIE executables.

Changes in v2:
- Move LC_ALL=C to the top-level ftracetest runner, as suggested by
  Masami.
- Keep the entry-point-to-file-offset conversion as the second patch and
  rely on the runner-provided locale for readelf output.

Testing:
- ./scripts/checkpatch.pl --strict -g HEAD~2..HEAD
- sh -n tools/testing/selftests/ftrace/ftracetest
- sh -n tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc

Rui Qi (2):
  selftests/ftrace: Force C locale in ftracetest
  selftests/ftrace: Convert ELF entry point to file offset in uprobe
    test

 tools/testing/selftests/ftrace/ftracetest     |  3 +++
 .../test.d/dynevent/add_remove_uprobe.tc      | 27 +++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.20.1
