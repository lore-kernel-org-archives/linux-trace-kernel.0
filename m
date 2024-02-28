Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F315D5A5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135807; cv=none; b=ZdLDhLEt5/NG7BpfVvQvDJTpmfVGPCtDNelnKg+J0gjAiPPEv1eOUVjzcy3vx/a2teICIzooPHiCtynHfwKvkyb3DWLCRMpBGkV+DCKYz04szR+YgOCIBGlazJhJBcnyDCVHkAA4ChXXD1ra6u5VCx1HLlLnKxblMn9i94YRji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135807; c=relaxed/simple;
	bh=ox0SzHrkavOp+g5hjoORZEvXYMGFdjHo91rhZXgD1oE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqO5rhq2jo4EKA10bSByCAfswGMKPvVAkYo5qLwJaVQPERQUKCdv3rWA376JHPFjrXQeQ4pJl4IDosLIkmLLTNpL0Lcz+hbahUyMQbxV0DkSTXxL5hCp6GN7IV9zKQvrZpb4GgZfyE0oCc16BvQrcZzpeSddcH4VbwgT046F3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37703C433C7;
	Wed, 28 Feb 2024 15:56:46 +0000 (UTC)
Date: Wed, 28 Feb 2024 10:58:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgNGB0LrQvtCy?= <xxxa0c@mail.ru>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: tprobe event tracing error
Message-ID: <20240228105848.009f1ad8@gandalf.local.home>
In-Reply-To: <20240228105252.5fb19b13@gandalf.local.home>
References: <1708954589.808811792@f182.i.mail.ru>
	<20240226234156.c6c647f5c005977327fde62c@kernel.org>
	<20240226121418.5143c6d9@gandalf.local.home>
	<1709130340.286978721@f107.i.mail.ru>
	<20240228105252.5fb19b13@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 10:52:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> The prototype of fchownat() is:
> 
>   int fchmodat(int dirfd, const char *pathname, mode_t mode, int flags);
> 
> Where pathname is the third parameter, not the first, and mode is the third.

I meant pathname is the second parameter.

-- Steve
