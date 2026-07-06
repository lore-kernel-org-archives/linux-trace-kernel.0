Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D5318146;
	Mon,  6 Jul 2026 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345131; cv=none; b=W0LAihpaiP9RzaPQ4wA06zUwTjdLfyb2AjTDwiHnQ+OPB5j4TZmx/Z7X6PGL29EM3Nl8nFj5inHtgquD3tY89qnTHzhnW43I12zn4bl7P9CocLz9/ijRj9ojhOAiqTIm12d9lT/O+fr6utl7loFVH5aZT4ImeUgbVXKzAiHFX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345131; c=relaxed/simple;
	bh=L5InHNMeS2peO9H59MIYUobdVy47Dw5/d+DWfQl5S6U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eZrnHnbXFjyrUpHXjaLzr4m0s/2TSLdDLfQSoTN4aTfE/q420EE4vE+xJHlOuNCs4oGAaY5FT7Q93Ucq5HHbHPNS3XxIT1xgr1mbjkmyIi9AkXb8JTu8Kbs6YMQwXGojQv0SLug0aR929LWIkTlYk4U4XzOPh8T+oKuDwGAEb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=S5WJHzLv; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="S5WJHzLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783345128;
	bh=L5InHNMeS2peO9H59MIYUobdVy47Dw5/d+DWfQl5S6U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S5WJHzLvFLAeBIdTDZQFlzJtDcAxwQ3vL2jIgBnRLAEReYDzR0jVXR/yrMk+JDYzD
	 n8Y3sRb8eZWViwUyqoVKQvtTujLuq2trZRx9laX55Ftd3ZClxNgZSjbuT468GLr0xo
	 sUlRXoRrgZQd5oNKxYVuIq3r9lKtEPtGJ06QagC0=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gv56c60v8zGpJ3;
	Mon, 06 Jul 2026 13:38:48 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gv56c3jHKzGpJ0;
	Mon, 06 Jul 2026 13:38:48 +0000 (UTC)
Date: Mon, 06 Jul 2026 14:38:48 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Adrian Huang <adrianhuang0701@gmail.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_signal=3A_make_sen?=
 =?US-ASCII?Q?d=5Fsignal=5Flocked=28=29_take_const_siginfo?=
In-Reply-To: <akuusnRXP_tyuiel@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net> <20260706-karpfen-beruhen-ausschalten-9f2b0a55b8de@brauner> <akuusnRXP_tyuiel@redhat.com>
Message-ID: <5431A102-B7A2-4FCD-82F5-1AF342B37140@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 6, 2026 2:33:38 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>Just in case, I can't read the code until Wednesday, but...
>
>On 07/06, Christian Brauner wrote:
>>
>> > send_signal_locked() should not change the caller's siginfo. Make that
>> > part of the type and keep the local rewrite on its copy.
>> >
>> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
>> > Signed-off-by: Bradley Morgan <include@grrlz.net>
>>
>> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
>
>Agreed, but IIRC this change should be rebased on top of -mm tree (I sent
>the patch which changes send_signal_locked(), and thanks for your review
>btw!)
>
>And, again iirc, with that patch "make siginfo const" become really
>trivial,
>we only need to add "const" to every "kernel_siginfo *info" in the
>send_signal_locked()'s callchain.
>
>Oleg.
>
>

Makes sense, thanks a lot.

Thanks!
