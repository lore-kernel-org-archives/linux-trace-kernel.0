Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC604F1F9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Feb 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706948207; cv=none; b=sIYUOSitRKHl2SI8bbGp4sFDVhnW4nkd6eQfCSUQYnxnfAWk+1kFd0nvqlpJg28a+fv8efNQ5vYbgmGIs11NKTYtJe8OpAClMAqgChLbiO/eBMac+m2KDWpxTC+Yb6wt7vXLN+OBSWcdf+KsRLVfnr+SM6LS+Vj/oKSb96BLZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706948207; c=relaxed/simple;
	bh=uJS6I+Lv6jFsCy05xCVW4cZeGI78Ls5ErQ3tAXWLscM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5GQmBSp93Lk0V9o5GjA8D/mJB2tm6c7Cxopbifd6S84TqOdfABpjAJpXXKLvJt10yb/16zCSEqhdHDlV0CodYufF4x1mw0HWbIG1JuGne7uUzSLUBH06UpiJod2gu6JNQWEerv8Vcm2tCHFzuAnUepnOxjNcaWf5HrwNlhfNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.27])
	by sina.com (172.16.235.24) with ESMTP
	id 65BDF65B00006F52; Sat, 3 Feb 2024 16:16:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 21109745089297
X-SMAIL-UIID: 47C4AB5C50304A94A40224F986210603-20240203-161633-1
From: Hillf Danton <hdanton@sina.com>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: INFO: rcu detected stall in nsim_fib_event_work
Date: Sat,  3 Feb 2024 16:16:20 +0800
Message-Id: <20240203081620.486-1-hdanton@sina.com>
In-Reply-To: <4db12050-bd87-487c-8298-7ac8e8393d79.bugreport@ubisectech.com>
References: <4db12050-bd87-487c-8298-7ac8e8393d79.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Feb 2024 14:16:16 +0800 Ubisectech Sirius <bugreport@ubisectech.com>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.
> Recently, our team has discovered a issue in Linux kernel 6.8.0-rc2-g6764c317b6bb.
> Attached to the email were a POC file of the issue.

Could you test if the fix [1] syzbot tested a while before works for you?

[1] https://lore.kernel.org/lkml/000000000000c041c206103c2f22@google.com/
