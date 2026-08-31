Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078D3859CB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148295; cv=none; b=GiHfSrsbnh4Ms8J/sNEJZachPClKwCY+quWdvMPvaFZplokujSWRFi83wOLx6lOQBMdff8X0OkzyJOfG7ruGQA2nfe7dQWYONh32mpxHkreUeUhdSBxZtvBTKbtp9IDEDnb7z+Qc0/SLIc7vFOY5IjO11IEd+904jKvcY8qIURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148295; c=relaxed/simple;
	bh=D3NavzyV7KU3YGjx7vQPk6D5wG9vWP7Ie6nPRhzgPho=;
	h=Cc:From:Date:References:To:Message-Id:Subject:Content-Type:
	 Mime-Version:In-Reply-To; b=OJqOEB4g9fGwWZX6qLfOvKk0vMKgo6Qol1sfPNN0AN9c5Ws76SeL3t7IwFgCtDIapAqHo1Ua65EFfx7JTUHcvoH/ioQDMCVP0ltHnWWLbDc0MYDxljFA1XoYKtzobhLXHeB6BZw3p9LnjlJzHybobeqR+mCOfJYKfp0cS8BRtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jjA/nPJe; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jjA/nPJe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788148279; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D3NavzyV7KU3YGjx7vQPk6D5wG9vWP7Ie6nPRhzgPho=;
 b=jjA/nPJeifN9mW7KHr4BOWLZepw0nt8gzH57iQSoACDQCvdbtqEpAOssisISh911CtFw5b
 i1VqgCRbrNyBCGfNQhXOYIlcsWbQxcmarAkGEza+InPnT1kJ0YUC7568LxcTFZUIf2eNlb
 1LYqyI6h7QaYTBcYScJ0Y3XxTXgKur0XI6pcyqBjzZSj9c4lcG2BSEgyGUBQ7sWKiKez7h
 LwdPRuGX9yKMGCvzRXbdtgwDX1UBjK7Yv1+fdvxOOPNtG4ENVDyHX0zzw8bVznTprEPZT1
 HQBrama6/jw8wcdWpDtCb22Psn5TSnzJ2bUXii0kSmk40Xt1Rz6Ne/fWl2sOzw==
Cc: "Rui Qi" <qirui.001@bytedance.com>, <mark.rutland@arm.com>, 
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, 
	<alex@ghiti.fr>, <linux-kernel@vger.kernel.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Mon, 31 Aug 2026 11:50:45 +0800
References: <20260707121235.759104-1-qirui.001@bytedance.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>
Message-Id: <20260901020000.1-qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26a94fa35+7a898f+vger.kernel.org+qirui.001@bytedance.com>
Subject: Re: [PATCH] riscv: ftrace: reject out-of-range non-direct targets
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260707121235.759104-1-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit

Hi Steven,

Gentle ping on this patch. It's been over a month since submission
and I'd appreciate your review when you have a chance.

The patch fixes ftrace_modify_call() on RISC-V to properly validate
old_addr/addr instead of always treating sites as FTRACE_ADDR, and
rejects out-of-range non-direct targets that can't be dispatched
through the existing ftrace_caller path.

Thanks,
Rui
