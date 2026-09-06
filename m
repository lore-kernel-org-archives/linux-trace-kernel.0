Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF273195FE
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788702672; cv=none; b=ohAroUSBgjGfsntLCb+eYwiE86UaF780Y/5t3z2awO/wJVswGnG853dQSBHRS2dm25ymNbcKXZMtE+TRN/+Yr8B4ItYleJgHg6liNufUW3raCh6JZR2wa4WBkjzQoq1cf4P/4veww0hyMZd9gloVK/crrdOsgsLdgejW3RAvH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788702672; c=relaxed/simple;
	bh=PzTfAdS+9fLuo1P9YI++Z3/Jco+RwdrcI6zo3wwgXPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnEZjRmILlB4OeEqufT6Es5lDHe7oQhV+Xb8l+dmIBnRs/rlqCIsbhNEBexHytf1yiVVU8aAh/4VpHY7OJ8c31DQXsMbbecTuInahFdWNZv4KsQdRNwVe7Gt8TfpKwdXpN6lVhziqq7S9jy+bOQ6yhBAIj4YV7MoI/dNKZ5dIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR6dnisD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR6dnisD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1976270b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788702670; x=1789307470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y6UtiMUQWTUlQHIqJjKIo+v5d4gNNZT+BR9XA7w+Syc=;
        b=JR6dnisDvv/4PftH76FmzbrHcZNYbwDQ7o1Uz95glKJCOk0EFJFo5rrlnB8ce6+1pn
         2R73Syv7xQM2feBMVfqhNwzVrpm88CIJ0Jr2XzablXVe5OwY8n7ACtKiqxNfTz/pVXMi
         dYZI9sJUC+y4CPF9ElRbGS9tQZhNs/PiavR1qQfoKZzUR8Z7XzcXZ6RdkPzsbGktSbjN
         opH7GzYhIWwqj4Gwl5/hw354lw/a2qnFgbaDdoInmlQAt7lcLoN3EIVSW+j98DC4y+sS
         VnXbjXxThuhjVnRxTnV4C8hBre5Ss/OSOMLDrFuXcTuE1KHWzPFF/ZbRfkRmCu8z31qR
         wmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788702670; x=1789307470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y6UtiMUQWTUlQHIqJjKIo+v5d4gNNZT+BR9XA7w+Syc=;
        b=cjQ/ALFrEcyOg6oWwcrPSNxjtNFIxwuufu8OxS1/G0Oj8fTceFez4Hf1Sl6gw6et88
         FFvdrlui7IK672pIbV7uBc7A02iCCHEPdhhC1XYs/ueQjc60jeYHKaMITLW+GieyG4mS
         uf7F12g4I+DI/ZIirNSCrbqAOx70D9KC9qgjrj8R4V4FRcPtIU4DStPweePJ8f9+TvRo
         XCu4Rvzff886BM7f/coAKmB19pvn1VFEXnc2DI21XycF/kFEXC8sLmASH22XnSJTMBd8
         fcrJ1bFLY8b6XezdOzywRCvJoqyTbURB4KKvT/MG4b4iIJaaRqsKdgowy38Fkj3uh68Y
         CVtg==
X-Gm-Message-State: AFuF++lC9snzLW+8bMZiJJ54MLnep1qR5a6L4MBLatUWt6XB7x9172Du
	E2Tfsit+hrNFVun8zQMr5QhF8dae6aTe+C54dAoz3uDVRZSO7VYE1XQ=
X-Gm-Gg: AYBFou3oOSHrvAcJv2PcJhDuMS8Nq8I1cuQUrrrWXokKkYCJMOw3zVc94XhquXWU++Z
	s2Sbx76ti6kMgOyhO+f7cy1SKvss6jId02DtcvjihUZWQQgKl05pL9BY0XVtbDXmfJmg0nrTZFK
	60SfGN4nJ4a6lXLZ/23VxUmnpKSjMNhEuzmPXyckuH+QZytKVW3zI72ge3peHPg3+ewBYaprygv
	wy3k4GylRzHahv1JgRke8gxKQ5uN+RMWsILAQV5eB6u7xGHVY6aIXHuJWs23BZmZkwF+CYbgyBy
	zayV9Zzo0FOQWY1YaqKT73Qq5DMMFwTmpSY91nox4xaNXWWP8AUYaseaQyBIKxWHEnn3CRg6Aqm
	ImmiMH+SlrWg/B4KlVoOBAl+7921Gbj0+yors6zzLDj2khMa+3RM29wwT4W3dPSW4Sj8kWY8RpX
	YdZH1O0qtfc85Rx3v8KVSlhxvIIfwz3yw6Tv2vAfV7fxmE3WcnfK5pC6OBVZdOSDVGLqUcRVV+H
	IzfpzxS2tak3jXg
X-Received: by 2002:a05:6a00:2309:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-861630c5ce5mr22606108b3a.0.1788702670118;
        Sun, 06 Sep 2026 06:51:10 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:2b14:fe4a:ab17:f236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86154048bddsm3271018b3a.60.2026.09.06.06.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:51:09 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] tracing: hist: free the var ref when its initialization fails
Date: Sun,  6 Sep 2026 22:51:05 +0900
Message-ID: <20260906135105.4092962-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906134553.71E331F00A3A@smtp.kernel.org>
References: <20260906133352.3815019-1-donggeunyoo.kernel@gmail.com> <20260906134553.71E331F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko wrote:
> - [High] Pre-existing memory leak in `__destroy_hist_field()` for variable
> references (`VAR_REF` fields) reused three or more times within a histogram
> trigger.

That is the bug fixed by the patch linked in this one's notes:

  https://lore.kernel.org/linux-trace-kernel/20260906124025.3550596-1-donggeunyoo.kernel@gmail.com/

It removes the reference count so __destroy_hist_field() frees
unconditionally, and the three-reference case no longer leaks. The two
patches are independent and apply in either order.
