Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F53CB557;
	Fri, 14 Aug 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717143; cv=none; b=T9F4AQv7apE5i5LvEQQEMLSWO9OdiDVoWi7Wy/4MPqr1qXMNM5ULdXINRO8bvlSfup2ZubVcbKhC/MDRXegyoTG8pIY/XNB/Iz0c5M2kis06W7bQ3OpR+txb+bLpO7kh3ijXfaRu+cohVcHXEvNklCM8AkXuJx17Eq9C3uOmvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717143; c=relaxed/simple;
	bh=Q+TmN1JIVy7gkOZojvQTqUqElMEE0KIoVgsgUVZSXUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFWveYKI4u0A9kb7ip8osafEzuo+mhj5atB+TXpi/4vv86Di+KOLd5bIqXabkbdYmM3xs3H2tpIUAA2K4mrDux7pjo4AhISFgf+EWUEgobprWsQ283PnTF0K3m3em4sGP93iSTJ6bB0rlOmCSRcYefseKVGmPgia8lPC3/nOUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=LDPJlfWb; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="LDPJlfWb"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 71EEA1A0158;
	Fri, 14 Aug 2026 14:18:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id C89EE17;
	Fri, 14 Aug 2026 14:18:48 +0000 (UTC)
Date: Fri, 14 Aug 2026 10:19:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for 7.3
Message-ID: <20260814101906.26679d49@gandalf.local.home>
In-Reply-To: <CAP4=nvRWKYdkfr-9_1OMupZfF0nUYVVtMd7Vwsd3o4pO__SCew@mail.gmail.com>
References: <20260805151055.870722-1-tglozar@redhat.com>
	<20260810210425.61435b0b@robin>
	<CAP4=nvRWKYdkfr-9_1OMupZfF0nUYVVtMd7Vwsd3o4pO__SCew@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6u3ouw5hy9hyd9patctkeyhwxijr9d7i
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C89EE17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Hq7wE/XzAV1MK8h2R1KwH1DWbhc2uqRw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=EYNGNYxM3MnMIjKN2EBIFLSNDVZgTmWXxI7/3svxB3w=; b=LDPJlfWbZxX5haYfnX/HGvN5OVyuf1N5r17sLxTA2QK+VuTGqVGPuQJ5LDYdYTPuXKpYjfiEP0izAbuhom8VZaViUZgcCFiTlPUDwQ1LuLNZ+RFMilKiJOghKbirvYv3vbOxYLj0/fqvUsrDiEFoTpERc7w7evoSa2mjv6Hq7uI=
X-HE-Tag: 1786717128-872253
X-HE-Meta: U2FsdGVkX18WQxHZRZN0lZDgek5OhkXOrvDbvxd2RLEtppD0gFzF88KIwA5zdiy4pb0rEBZzMo5Wk8fFhoU0SNaWB7t5Cj7UrxzvpDtTwPyzGSoMOBsOskuvc/MszdGJdtOrGUvrDRdMfoEtuwcJJC5HaNZ8h20kgXxJsG8QuEY0+NkrhezyK3st2hLSqqll0cnCsGqFzuTvJAqlpDUyQrc2tmbSh/qxKK+pDxrEoMVk5avrFrWZEyIKXsCN1hre5rSHFUFUuF2mVLSdD6VKxITXxIkvKQ5RXBULz1Awy75CsxurPkrSZl1Jds5aVWS5cFqDmQ7B0rAJgYbOv4UgFCipx5GmZU7N

On Tue, 11 Aug 2026 09:22:54 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh is for some
> reason not finding the user threads (as the tests for -H and -k
> succeeded) on your system. The threads themselves had to be running,
> as timerlat is reporting samples from them. The script and the related
> tests cases were added in 7.2 already, this pull request does not
> touch them so it's most likely a pre-existing issue.
> 
> Either way, I will look into that, thank you for testing. It might be
> environment-dependent, as the test relies on the test script (executed
> as an --on-threshold action) being a direct child of the main rtla
> process - which only holds when the system() shell executes the script
> directly, not as a subprocess.

I just pushed this to the for-next branch. I'll let you figure out if there
needs to be any more updates.

-- Steve
