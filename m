Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2E566A;
	Fri,  8 Aug 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676086; cv=none; b=MEORFsbvT2HxwKPoHcJxtdg1jMKzJUdSzN2wEefIBzZ2pHKBMJKYfPUbyUi938wCStsz5NdjjuxubKjnHcMAH06dE4Wxng6Jp4MmzxqJZr9mPYwyfXdLu/Am0DennZJhal78wg++xULmC6scYuKHcZu65wrXdE3hLGUbECMLWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676086; c=relaxed/simple;
	bh=RABZXaFQf4N2Hg9BF5BHvMjjVcK+NorbOVS/ZzxMMj0=;
	h=Subject:To:Cc:From:Date:Message-Id; b=YylwMZoJ2o7VrFc31kh8qB4IJpRzRrRxhIsjgbEGxax1vptVX6a9LTGPitZHhUGcphbrnhCIxCino4hDmJMPWuGXu86vIgabsUcO4vvGfY+Ex2QrBJiDg9E9P+ISB4FsFcsZiyXZXdg23Rfns7RfAL1/3aNZA1hKLEryLObOQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US0vKcPu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US0vKcPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754676085; x=1786212085;
  h=subject:to:cc:from:date:message-id;
  bh=RABZXaFQf4N2Hg9BF5BHvMjjVcK+NorbOVS/ZzxMMj0=;
  b=US0vKcPubae6wkxJdrw4VV4098rxZ/BT9PR11FEnR4VfLkgBW4HQbxj4
   ghzMCACLVeuceezRNSMOZramOVQYplHqM/nDTr+gaYM8FzcykbGg7GU9H
   qdcm5Rw6YfM+CFPs/J4NkK4btO2dCjpIGn3yoIyjojzRL4yuB0FRcfFdG
   b8dlCpYAJ2gpLl0PfO8OOOhrQO+rXGla7cra3lUUSUCScc/pQdhBpIvjf
   /nqdYbjCDyLKfqABu2iL90NeCJksdQlum+1w2fNmTwczzY7/YU7/9LR2e
   77DrkVqEBpxXX9diKzQzi9BlNUTCvPAdwQP/uMnFL9bDBhenb6FZPEdWR
   A==;
X-CSE-ConnectionGUID: JW5lRwxHSwK4Yg7PMy4xCA==
X-CSE-MsgGUID: RKhHGQpzQt+1ksqWRNTRQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60876135"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60876135"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:01:25 -0700
X-CSE-ConnectionGUID: JywwJG2+TOyymVUpgfXgEA==
X-CSE-MsgGUID: I3k1UE/CQaC7ZWgXgs93yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="189087711"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa002.fm.intel.com with ESMTP; 08 Aug 2025 11:01:24 -0700
Subject: [PATCH] MAINTAINERS: Remove bouncing kprobes maintainer
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao <naveen@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 11:01:24 -0700
Message-Id: <20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The kprobes MAINTAINERS entry includes anil.s.keshavamurthy@intel.com.
That address is bouncing. Remove it.

This still leaves three other listed maintainers.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---

 b/MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

diff -puN MAINTAINERS~MAINTAINERS-kprobes MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-kprobes	2025-08-08 10:57:53.686216444 -0700
+++ b/MAINTAINERS	2025-08-08 10:58:00.237773836 -0700
@@ -13681,7 +13681,6 @@ F:	scripts/Makefile.kmsan
 
 KPROBES
 M:	Naveen N Rao <naveen@kernel.org>
-M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 L:	linux-kernel@vger.kernel.org
_
