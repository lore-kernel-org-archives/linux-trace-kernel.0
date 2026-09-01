Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326204908C5;
	Tue,  1 Sep 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285387; cv=none; b=XVshRhs9Ev7qWpC5tcJ4S/t/LgVdUFlPVl8k44WcEWWkIHKjCMFNMTu6WTP5tHeHExsKCfUdAwHikKNNPYmjSsJ6CKBfb//7V26gZNduDS5ODHWpgGE2YaCe7fkAAPBxy8/4VtZ45ulGuKv2QBWB2ylPh8s1GpcG68xhCGOPkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285387; c=relaxed/simple;
	bh=NXB828F0BgwZ92XkDH9xZRFbfVEHyziPgYk/0bHDQgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZFxoiuN7Yc7c/nvo+OOp46keEE3LjxpVrPuBFvB+CCovkUEo+12VNXuqGxCtUvCdukel5+vk7yvhq5gSk4ED3vZA9vgZkLZY3SI6bdNdEnrxtxM1Di50rjOwilg5cyhTV1ZKcC8yiChD6/ahkPFT9P1eZBrfQOzwO5oNbT0hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Dc2Opkm8; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Dc2Opkm8"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 276F2A4339;
	Tue,  1 Sep 2026 17:56:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 4D51A30;
	Tue,  1 Sep 2026 17:56:16 +0000 (UTC)
Date: Tue, 1 Sep 2026 13:57:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
Message-ID: <20260901135715.4812fde9@gandalf.local.home>
In-Reply-To: <20260901134604.4052265-1-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4D51A30
X-Stat-Signature: pu4igh9jgu75cw8y8jnk397nm6wo6ekg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18iuEvvyqdqLWYPqNrtu2UsEDi8D/6Ywvc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=b4sFRfNQ0tyv8pW4Ve/mW5zG6sCiOyA38H38CK7BhmE=; b=Dc2Opkm80SuQE2M1MjVYNLYUUoUdxAB9LzGzgZzqzCmraTo1YZa9xfZJoZ/e5vwEtGxdiI6Vf7zyD5ep/2cdRbtstI+9g5V1zeNGLQaENKZyf74BVBYisu3xuoNhaxXkh1CPne/ZXWW/G8/KgtOWjM2ys4caP51VWtaobe0p8U4=
X-HE-Tag: 1788285376-230469
X-HE-Meta: U2FsdGVkX19HCQSdVjaPdJKBJJI5BjU/6roxVsAWeJfnYCyZE3JmtO39r6YvWAMc1NBZKNAnMGqyY+cnRcgHPLnHIs6ZEx2ceAGWZNyeXhD5FXqKm9cowUoHilYmsHyWcnPIr7h4IScfNNZWWdiIylM122vIyXKmNomT0xDwJicYMNHNwemD7H8ES0dW7Gq59EL2sQmlkyt38/Vz0T782jsGDo0Qygnc+kL6oiewultudZgIsi11vAiU5iyIc32DMGb3B7wx1GUD1MAXaurmWRBwz1L3bMVcKQILitFMBHYhu7uhKqekasdRwEAXenjVqFj7TYQICbqfEK18U5dywJcs7/0ol2I85KZ++1aNSMbDpVuHnNrtvw==

On Tue,  1 Sep 2026 21:46:01 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> The funcgraph-retval option currently records one machine-word return
> value without considering the function's declared return type. As a
> result, void-returning functions can produce meaningless output, and
> return values narrower than a general-purpose register can include
> undefined high bits.
> 
> This series uses kernel BTF to identify the return type of traced
> functions and to improve funcgraph-retval output:
> 
>   - Do not print a return value for functions with a void return type.
>   - Trim integer, enum, struct, and union values to the available return
>     value width when the BTF type provides suitable size information.
>   - Format integer, enum, and boolean values according to their BTF
>     encoding.
>   - Mark values as "(trunc)" when the return type is wider than the
>     value captured by the function graph tracer.

Hmm, I really don't like the "(trunc)" If it's the real return type, then
it should just print what the real size is. No need to state it was truncated.

-- Steve

> 
> Here is an output comparison:
> 
> Before:
>  # perf ftrace -G vfs_read --graph-opts retval
>  ...
>  1)               |   touch_atime() {
>  1)               |     atime_needs_update() {
>  1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
>  1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
>  1)               |       current_time() {
>  1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
>  1)   0.352 us    |       } /* current_time ret=0x69380753 */
>  1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
>  1)   0.937 us    |   } /* touch_atime ret=0x0 */
> 
> After:
>  # perf ftrace -G vfs_read --graph-opts retval
>  ...
>  2)               |   touch_atime() {
>  2)               |     atime_needs_update() {
>  2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
>  2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
>  2)               |       current_time() {
>  2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
>  2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
>  2)   0.753 us    |     } /* atime_needs_update ret=false */
>  2)   0.899 us    |   } /* touch_atime */
