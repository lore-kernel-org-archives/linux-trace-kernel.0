Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF62AEF5;
	Wed, 18 Mar 2026 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794613; cv=none; b=o4i/dqWgc1c2a16MYHAyYF+qdcbQHdXK7/klfhl0YPSsn2CBzYN9SlNSVnU6sHL9euDMDQ2Q90hDokpEh6olPP7NbGbTvtn3XwSMgDs6kiWgUnXdvs1izGLyMNJzhWFvCUmir5VOQE7t6LH7SVrXtORUhFs0hSivkLp3YvyBD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794613; c=relaxed/simple;
	bh=iOeao65Pgs2YWqQF1Ax7rZss8oQc2fDSoGdzq6eP3ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlnrXqumtMVPpfg9gNz8MuXfVDou14GJvQT9aJqHrQU0iFS3VPbCofOqB+Vht8P1U+Ed/WM/WHsTbMso8EdvNY+Dy3m9OW5iJdVKEITWfpQelmS6/dZXJEwPbqJ9QL4Ye5+B+JcelFFtTC5ZVhmOk/aK6/ODFmNSFsIgILRffYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 565F2B9933;
	Wed, 18 Mar 2026 00:43:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 9559942;
	Wed, 18 Mar 2026 00:43:28 +0000 (UTC)
Date: Tue, 17 Mar 2026 20:43:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-ID: <20260317204327.3c61d0ea@robin>
In-Reply-To: <20260318090243.7c437f2c5e07a1ce00375102@kernel.org>
References: <20260317204403.72375-1-objecting@objecting.org>
	<20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
	<20260317191626.5b6172a9@robin>
	<20260318090243.7c437f2c5e07a1ce00375102@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9559942
X-Rspamd-Server: rspamout06
X-Stat-Signature: 66xcak9mi6xehqkw5q1h3fp6e5z36q3b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EzUVvOrPJgbXgSUziAR8je8EkaKBwii0=
X-HE-Tag: 1773794608-463870
X-HE-Meta: U2FsdGVkX18MwtnC4E1ymgbCuY9AYyZ0mssSnDKgvjLv9D/LWui4cWiaZPeQCvcE5d80i1QNBiZp3oyM12uZkTJKSlJ+ZrAgYYUC7h5RTGjJ4jkMw/zYbg4E3t8zjA6OqEVpqMCIF6zqqadD4jTkhBRGmBT/6qFwUA7aP+g1FczxXNdkSTz+Bk3I6LxOopjwRrwMpbx4TC3pYDhqRl5QxEnL+PzYeovHB8sLQ39gppfjkeSE34A1WlTRflGyYn/0NF6Nchv4I5pYwa++Ulnk9o2AxsEIx5U8/kWqe1w1efoUacIFaDEgPxXq5CRRwYfzVW4taWdzu8CLyAr9xH8HsaCMTBc2iknJ

On Wed, 18 Mar 2026 09:02:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yes, that is checked in vsnprintf(), not its caller.
> I think linux kernel should ensure the the return value is smaller
> than INT_MAX, and return -EOVERFLOW if not.

Well, there's very few places that could have a buffer size of > 2G.

What's the max bootconfig limit? Could you create a bootconfig that is
greater than 2G?

If not, then yeah, we shouldn't really care about overflows (and that
includes not worrying about typecasting the size variable to int).

-- Steve
