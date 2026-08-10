Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662928F5;
	Mon, 10 Aug 2026 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401967; cv=none; b=Tm9zkO34ZLBLCg4MbqXvTACOvCxAo54/wv1+FQHJaQkmGiCRPm53BUSGMSgpNrwzUVDnbf8rPDv3qk95fQRVlZL3Lf269WbVsR4BeNpN0IjuXRYmqhOhSHqwnyRPOyw4513L7iqOko80VGbO0to5Sum334ItQmfdvHyOOzeaS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401967; c=relaxed/simple;
	bh=QhMXrfraOvdh9YrEuAVwdoG/FYIJ1/zDvQVpJizxhYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvrPwMhdyszEBnt6r/z4f6R2DU3fotyz+rlEBRcBH8Yma7kVkMRL3ArNxszFoWu9WHh71xcT8LRlztKqi8dn/Hg46QnD/yAgIp/PMZUgVsszCEcJtCHfoh7qfsukgosPoG8+ZssVNgBwRMcBrV77QB9fm0ZPulsBQ+eCv30Q2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8FA821A0276;
	Mon, 10 Aug 2026 22:46:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id A2DFD20011;
	Mon, 10 Aug 2026 22:46:02 +0000 (UTC)
Date: Mon, 10 Aug 2026 18:46:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/18] tracing/remotes: selftests: Add a test for the
 dmesg tracefs file
Message-ID: <20260810184601.2d42dfd7@robin>
In-Reply-To: <20260804140333.797210-8-vdonnefort@google.com>
References: <20260804140333.797210-1-vdonnefort@google.com>
	<20260804140333.797210-8-vdonnefort@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sgc5kts4ws4eiiqcz3h4z5y9kmxadqg1
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A2DFD20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+f0IQSllQciosXMuF0Ho59ciuuITY4j0I=
X-HE-Tag: 1786401962-119
X-HE-Meta: U2FsdGVkX19nwoFB8qFBI3vbgl9RiDMLvWATZ+/mYMyCBMeleVTSWd5Wm0VTCdvcYtNdyP3gymBJhlrU2h33KIQRaa/NIDAjXv+o/ynbFA5t9c9BCjxZbp0KthuXXC1bks5fH/sHlqY1vdgOMgKY1QixJraywPB/A9UdJaJi0/jXBhgroBspL3Zh+uhqdQVkK1neP4qWd0ZAQPBMlMYMdV+Cvqp/o8PxrSQJ6ONwt9WsfXwI8Wwit15O0ed6NCPkrey6HSrFslQwlQWRV9nvV8fkASHRfeLiZjAdFNdaayczDnNUNflp7IGkbFSdmEMWJ2pwVFLg294UmMqZpB7KNcem8HOD76hn4IK3GRS9CE0aes43dEXgtRWOpRQVN1g1gk/D3/bBA8oCOujr5A9P5g==


Adding Sashiko review: https://sashiko.dev/#/patchset/20260804140333.797210-2-vdonnefort%40google.com


> --- Patch [7]: [PATCH v4 07/18] tracing/remotes: selftests: Add a test for the dmesg tracefs file ---
> commit e79aa4baf215905a3bfd330e32c4f3d3b06f9a1c
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: selftests: Add a test for the dmesg tracefs file
> 
> This commit adds a new ftrace selftest for the dmesg tracefs file. It
> exercises the dmesg redirection by toggling it on and off, and verifies
> that events are correctly logged to or withheld from the kernel log.
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> 
> [ ... ]
> 
> > +test_dmesg()
> > +{
> > +    echo 0 > tracing_on
> > +    assert_unloaded
> > +
> > +    #
> > +    # Test dmesg on/off when tracing is disabled
> > +    #
> > +    echo 1 > dmesg
> > +    test $(cat dmesg) -eq 1
> > +    assert_loaded
> > +
> > +    echo 0 > dmesg
> > +    test $(cat dmesg) -eq 0
> > +    assert_unloaded
> > +
> > +    #
> > +    # Test events are logged to dmesg
> > +    #
> > +    dmesg -c > /dev/null
> 
> Does this indiscriminately clear the system-wide kernel ring buffer?
> 
> Flushing the global log buffer destroys all previous kernel log history.
> In automated testing frameworks, this can suppress earlier warnings, oopses,
> or bug reports that occurred during the test run or kernel boot, making
> failure triage much more difficult.
> 
> Could this be adjusted to isolate the test output without permanently
> wiping the global dmesg history?

I agree, tests should not clear dmesg history.

-- Steve

> 
> > +
> > +    echo 1 > tracing_on
> > +    assert_loaded
> > +    echo 1 > dmesg
> > +    test $(cat dmesg) -eq 1
