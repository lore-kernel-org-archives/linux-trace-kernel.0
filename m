Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092F43CE56;
	Tue,  8 Sep 2026 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911213; cv=none; b=E0Efpc3KkjAwXPJI+3VJI8B8NQnIqETnIDfk4CSomIxoWm3MxHaEkBsBF0n9I/ZJXQksRul3469HH9wDS4bR8AKxc2ACdFXgSLn7y9VdxehIKc79ajx6P+92fbgtDnoFBPfEtkp7X3ZdrR4cqfI2jbC652VtAvHwgJZ+PMVgwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911213; c=relaxed/simple;
	bh=6vCcIIQVnZPoU4q7D2c9z019f+3J7WNmqcOzGdrT6kc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W+DTSjlcXwL3GCXZwizmCUYOjNEuyiy30RjGkVvyN3aD/87x7qjuoFfa4PaTw6FUWyPAElAblipdomh8HQ3YyjnT0/VjPOueJ8BkqgELmotM0RaSzXu6LBscvUPauc1r1Y9CWYG0/n2G3krfADB7+vggb8K0tR8I1lSXpndty6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1+nmUsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1+nmUsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8349B1F00A3A;
	Tue,  8 Sep 2026 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911212;
	bh=s76MEdgN6Dlw3VEj2tiygClyBZDsu40WfSu1krSscek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U1+nmUsaenYMonLuueN/haGrGg4s69pb4x5XFrUrrO+zT8/N9DrZ3fTWwdLY03pZW
	 qg5TBDLpiKcICA/PlLxjPnI5y6sfSTOx9GW1CpkX5zUep1Sr10OqiY+SQlf+cws0WR
	 PLYVEQSguJgKTRnNcRlKGQwaqOgsvg4Ukbd3IbrC3gOTKybfH7bS85ghsxrkDMgPOB
	 4ZRD2H+6LX8phjpeqxUCBdMkIsHCIWPZFKsNZxGBwfBfWunjH68mahhxrFY5/iQe3u
	 rJ1G8L3ck36ekEw9TD795e746QUV8f926PXh6CV1lDTj+tsyFD6ow9wpN9cBrxLyda
	 jdP8gNT73DSkQ==
Date: Wed, 9 Sep 2026 08:46:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: davem@davemloft.net, include@grrlz.net, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, naveen@kernel.org
Subject: Re: [PATCH v2] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the
 enabled knob
Message-Id: <20260909084647.e2d9cf350e7e98df6032bee0@kernel.org>
In-Reply-To: <E69D1F6E-8329-4A67-BCEA-EFBFF91E57D2@mainlining.org>
References: <20260908101017.a4a72b4c93b51571d0fbfbac@kernel.org>
	<E69D1F6E-8329-4A67-BCEA-EFBFF91E57D2@mainlining.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 16:19:00 +0100
Bradley Morgan <brads@mainlining.org> wrote:
> >
> >
> Hey, can u change sob to this email if possible? Check lore link below for
> info
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

No, but basically I can add your new email. Or can you resend this to
replace the new one?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
