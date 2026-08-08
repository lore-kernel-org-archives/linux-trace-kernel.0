Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F6367B85;
	Sat,  8 Aug 2026 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196586; cv=none; b=RiX6FQF+r46RNBoeGZY75KT42atG+lk7ifdJP9zc+EUzNIStEsProCGxcepvTrVD6LcUocGPEomUHqMRjdRunL+ZxWpkIjvXRnQy/zyyc/1KA+EKCQ6W3nPLuKN1smIkkaCAwiwWIGBjEOiEQWbXqH6jM8A5bNKa5A1rfHAHzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196586; c=relaxed/simple;
	bh=sNyMjr0y0i9uCrSXmfSvcE1Z9qTktFC2JkX3O4ZZbF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS+OVUN9xmGqfe+6c4GA0dhFkZW6NrP/nY/b0Huci8lLNfpMCyTShKcsSTWVFsrBZStmdM8WceIO2uY6EPx7cR/9sdCJb5JX8oIob6NPmbZzgNIwoCIcngzR1kL6eKh7vXU/+8lZnOuE7O47YeMkdid3ksBPKhXAKNePkcOHcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 87D5F1603C0;
	Sat,  8 Aug 2026 13:43:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id CF0DF2E;
	Sat,  8 Aug 2026 13:43:01 +0000 (UTC)
Date: Sat, 8 Aug 2026 09:43:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] eventfs: Use children field for rcu head and add
 memory barriers
Message-ID: <20260808094300.78519dba@robin>
In-Reply-To: <20260808094215.4252430d@robin>
References: <20260808094215.4252430d@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CF0DF2E
X-Stat-Signature: 3eectdz97s36npz1bn314epfqq1w6omk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IdQ68l256avZTBK51koZ1Yzo78k53yBQ=
X-HE-Tag: 1786196581-129905
X-HE-Meta: U2FsdGVkX18swjiuYk3iaFA6fmGPrWA85Q2LARdBOzeNEeigpYSfUXgBVOR2eH1lhTzMP/W3hUjUuxyNSVk9Ov5vwt6nn0FIQUpKPj2tPmPAFZ1tpcg5iiw4drchJydxwCm+nlLPm7uUUBBl2onZkb3VCv33dTDV9M7G7lxqfXDgGrhlhd3ANYhCWkD8zvhIbxpYcC31BFeMf3Km7LJsQMNH82R3ve999ltHZBYtJSQMdbsylLV/N95O6ntseP+DJ7S1IQvNl7Irxmyv083SsIoIUDcCOQIdE1TIDz2nv6ibq6TN6kHiDrqKbuG7zCbf

I forgot to make the subject say "v3"

-- Steve
