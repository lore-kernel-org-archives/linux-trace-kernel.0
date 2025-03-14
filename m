Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93A1C861D;
	Fri, 14 Mar 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946364; cv=none; b=raaOi8f77Ox8vaJlU4LK/t/483CwU3a+W0sigjSIFEvZUaqtjHvVm7Vo+a46wg048LR9G7XWMOpnzRBxb+Wv03uOLH1HpuWPNnFTB6aLsy6yMYfT74LPs+3JrNrqpHt+aLBe2tArMiwefevvMg5JUiA01iRhoJRIhTp15K9YgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946364; c=relaxed/simple;
	bh=BfJs3xJ/8+3DBAd628hTkwQQpWB7LTqi4Flk588dWvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgQRVmAAe5oDSwSFURW2FDhL9SrToKBCjrLKuMIisqDNxy61OKtCSIpFkFi0VPrKxdtVkB2T/mT2GzjZywMzdzTIRl31hR4IbDZ+7rJgu3ctccmi4iL+sppIik+DsUm4kWiFyNypRRyuLN1E45PBmT5E35JbMKjPz655lN+Am2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: g2FWTGohR9eXJyPCkx3HuA==
X-CSE-MsgGUID: mTHgU7qSSXezUobjR1s75w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Mar 2025 18:59:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 848B6401FD9E;
	Fri, 14 Mar 2025 18:59:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	biju.das.jz@bp.renesas.com
Subject: [PATCH v4 0/8] ring-buffer/tracing: Save module information in persistent memory
Date: Fri, 14 Mar 2025 09:59:04 +0000
Message-ID: <20250305164539.379008535@goodmis.org> (raw)
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305164539.379008535@goodmis.org>
References: <20250305164539.379008535@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <20250314095904.hMaUc3cXhr61SvDz_MN3Az8hojWmC8zsKuFudYNTIIw@z>

From: Steven Rostedt <rostedt@goodmis.org>


> This updates the persistent instance to record what modules were
> loaded and what addresses they were loaded at.



This series is giving build error on linux-next for 2 days(next-20250314
and next-20250313) on Renesas RZ/G3E SMARC EVK platform (ARM64)

Reverting trace related commits fixes the build issue.

build-errors:
kernel/trace/trace.c: In function ‘save_mod’:
kernel/trace/trace.c:6041:45: error: invalid use of undefined type ‘struct module’
 6041 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                             ^~
  CC      net/ethtool/phc_vclocks.o
kernel/trace/trace.c:6041:51: error: ‘MOD_TEXT’ undeclared (first use in this function)
 6041 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                                   ^~~~~~~~
kernel/trace/trace.c:6041:51: note: each undeclared identifier is reported only once for each function it appears in
  CC      fs/proc/cpuinfo.o

 
 


