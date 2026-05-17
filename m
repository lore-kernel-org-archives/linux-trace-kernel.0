Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98333093D8;
	Sun, 17 May 2026 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779036834; cv=none; b=PlygqT+xQjt5gSm8aulMry+w9ldQfARCSbY5OMkfI8V53hqepqv2ACk7wn6I5SXpOcUInn2RC28t/KkmW+6K4WaYrvOrFyJketiN4A8MJljN8aaxDfVmKOyZs29zWYrthoknLMC+gTD5rQvF6RrfY/ecc5v+kKDeiLNvzyaAMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779036834; c=relaxed/simple;
	bh=nBUfjRP/M3AtMmrRIahqncsXIavsDhRmy95vpC8GxHw=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXN+3owquZdT2patxzl9TNG/fiJae3i08AVauVoItQTzOAS1lZQYkF0tyDlcSUqJGbRNhvVcFq6V6fGRMFJXEkyskosa/8YbIIW+3hDZfkJckFM2VsWP7xK3Jjw/oQk1kxrxDB3pVQ+RRWrQOu8z64UzJewS3f6RucfoCLfQ/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2448D1A05FF;
	Sun, 17 May 2026 16:53:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 3D14518;
	Sun, 17 May 2026 16:53:44 +0000 (UTC)
Date: Sun, 17 May 2026 12:53:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Afi0 <capyenglishlite@gmail.com>, security@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, Greg KH <gregkh@linuxfoundation.org>, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: Race condition in __modify_ftrace_direct() between tmp_ops
 registration and direct_functions hash update
Message-ID: <20260517125343.39dc8c85@fedora>
In-Reply-To: <CAEABq7dxnaLrTOhmD+tKnDenmZTUQD8sG=eoxe72mi_gwaus6g@mail.gmail.com>
References: <CAEABq7fMcvHpp4+59Mt-QdgGNpWhOqrGWHKmy+qt3tJSYb69kg@mail.gmail.com>
 <20260517091510.7ea4cd28@fedora>
 <CAEABq7dxnaLrTOhmD+tKnDenmZTUQD8sG=eoxe72mi_gwaus6g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yiz6wsnbu8mua784j1nha68n65wc9xka
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3D14518
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kJekch7B6Jc3KPo8aE34rUKihjpGNWBY=
X-HE-Tag: 1779036824-94028
X-HE-Meta: U2FsdGVkX1+JSLQE5fcxVP96ArNzeyvXLWU0Oo3FjJ4KyQ8s+cdXSZtrPDtq1H0YeOm05srxU71vpsy6bEuEpWvVIuBqjztO/TdS6XGQ9zusBIQxcl1z+LxUX7YsYhqiui+XLROonrRLwSfTjF69hygNtSc7GDdiehvBcjwHd7T8hbozFCjfhNzuDuwhY9kadaJCAjJi13t+H+XoToDQqfYs4b9WS6V28A9onX83+tS3W0ckSVNF+8UBYH+rc1fuCkTmiOrK2KSvOJQrQdCI/Yamm0EjIiuY2leHXBuJDD5Y+jMo4UtFL6AEOJUSIlARPNMNrMXU6e9fnsf6LtqtMynTgHZXkHmeZZQe2r+cCXwsY4M4WUfyR7BW3xxKT8ycFuvfiuENoFQ=

[ RESEND - I didn't realize you replied to me privately. Adding back Cc list ]

On Sun, 17 May 2026 15:16:17 +0000
Afi0 <capyenglishlite@gmail.com> wrote:

> Hi Steven,
> 
> Thanks for the detailed feedback, and for adding Jiri.
> 
> You're right to challenge this. Let me clarify the exact scenario:
> 
> The race is not about direct being NULL before assignment. The issue arises
> specifically in the *modification* path where an existing non-NULL direct
> is being replaced:
> 
>    1. Caller holds a valid trampoline at address old_addr
>    2. Caller calls modify_ftrace_direct(ops, new_addr)
>    3. __modify_ftrace_direct() registers tmp_ops -> ftrace starts using
>    tmp_ops
>    4. *Window opens:* CPUs entering traced function read entry -> direct =
>    old_addr via ftrace_find_rec_direct()
>    5. Caller, believing the update is complete after modify_ftrace_direct()
>    returns, frees old_addr
>    6. entry->direct = new_addr executes - too late, CPUs already jumped to
>    freed memory
> 
> The key assumption being violated: the caller cannot know when it is safe
> to free old_addr because modify_ftrace_direct() returns before entry ->
> direct is updated. The API implies atomicity that isn't guaranteed.

But __modify_ftrace_direct() calls unregister_ftrace_function(&tmp_ops).

Hmm, tmp_ops being static may be considered part of the core kernel in
which case the FTRACE_OPS_DYNAMIC is not set and the synchronization
will not be called from the unregister function.

> 
> If the convention is that callers *must* never free the old trampoline
> until some explicit synchronization point after modify_ftrace_direct()
> returns, then you're correct that this is a caller bug rather than a bug in
> __modify_ftrace_direct() itself. Could you point me to documentation of
> this requirement? I may have misread the contract.

I'll let Jiri answer this part, but it does seem that there should be a
synchronization to make sure that the code is freed. BPF is the only
user of this, and this is a new feature.

Jiri, if the modify_ftrace_direct() is used to change the trampoline,
what synchronization is done to make make sure it's not called before
being freed?

-- Steve
