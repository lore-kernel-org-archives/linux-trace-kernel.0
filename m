Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BE3955FF;
	Thu,  3 Sep 2026 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459933; cv=none; b=U9g68jJOt0MSptjbAeozZJiDxF0Uy3C6sjASGNbbTmedrstpQBbrrR0Br6Su646NEoY9ldD8YOziSJzVutkKQVCDqm+LCuLs03F6WNIZk5OKQFJ07Ijt+yQ7J1OHGeXEji/EHUi0KCXQp6ERzqKmTDzvYWKW8yUGo2DFyQ2o0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459933; c=relaxed/simple;
	bh=2Ij2NlyO6wogsQ73+AtvXckQ+dTFqd2wJhNmkrJW1eg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eL6sGRKtlD9dVAu0MKUlj9b7Kv0etPAuXt96gqUveqktrnTAUUi62J3k8xgHjBVHHE0pwFG/VOwApIJtR/0u1EcmkDENb/Fk8bBkM7bW/YwPAkNGp54Ls872zpAHwzV8IaNiFReDPAtA+Swfkylg5tvaCPJ3z19CYXtvL2T3bpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=S4c9afk0; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="S4c9afk0"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2DA87C0635;
	Thu,  3 Sep 2026 18:25:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 5225E3E;
	Thu,  3 Sep 2026 18:25:19 +0000 (UTC)
Date: Thu, 3 Sep 2026 14:26:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] ring-buffer: Allow splice reads on static
 buffers
Message-ID: <20260903142622.774ff437@gandalf.local.home>
In-Reply-To: <20260901155445.1475405-2-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5225E3E
X-Stat-Signature: 85o1pitot87puzt3opx3atraixt8jw18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++D3RZJWQtnwOMRyM73CWtONQRQY8lZWM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=sg0+HWPGveDO6RonA59WftFNQoTn3FekFXYEsfKwMtg=; b=S4c9afk0XeX1KKWM1KxudokyoSody/dS86CUJf/5Gp1we3Ox3w+ZGbxI6jW5aU/mnk59w4AdC3s0bKptiJroxyD/9QFz+Awms347+hCCETlxFwfurkOT9JEWqwnGpayinCZcvKPZ/56wGAdh8XmeQKy7TSuf5Exi5KqUJRxVbBg=
X-HE-Tag: 1788459919-119601
X-HE-Meta: U2FsdGVkX18aMHM3doJ0W8/4VGKrf1DiXYVjsjV3XSm78BSRlRFosZD9QlOwFfzcq7TZEhl4jKbZJ/AYAFYChbWlMbh5IBq0yhhzbHT1sX2rdNES9aBdICxQfA0VRH+xXchIZecfZCNiFRzPhF0BFvLn7FJqpiFDW5I2gzdH6RjbwPiPhz8Uw3q0dCMtSBCbF0at2dekJvC48C2xUGcBqJnEGMEm4aXeH7jnK7Tp/XlDGvRu/CIGcxZKrx9jUw2c6BFkEAoNYckGBbylWev8dN5C9TYD22ZH1b3lRTSKiBjemtuJ0kCFJZK6/fRytPoum7uiKupsh1ZUSS+ibj8oNo3IBwv6SBds

On Tue,  1 Sep 2026 16:54:42 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> ring_buffer_read_page() rejects splice (full=1) reads on static buffers
> (that is user-mapped, persistent or remote) because !read check assumes
> unread pages must be swapped. However for those buffers we have no other
> choice than memcpy the data.
> 
> For the memcpy case, only return an error when the writer is still on
> the reader page for the splice interface to wait.
> 
> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

I'm going to apply this patch now, so you can drop it from your v10.

-- Steve
